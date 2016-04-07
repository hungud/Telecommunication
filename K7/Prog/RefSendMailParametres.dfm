inherited SendMailParametresFrm: TSendMailParametresFrm
  Caption = #1055#1086#1095#1090#1086#1074#1099#1077' '#1089#1077#1088#1074#1077#1088#1072' '#1076#1083#1103' '#1086#1090#1087#1088#1072#1074#1082#1080' e-Mail'
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    inherited ToolBar1: TToolBar
      Height = 31
      ExplicitHeight = 31
    end
  end
  inherited Panel2: TPanel
    inherited CRDBGrid1: TCRDBGrid
      Columns = <
        item
          Expanded = False
          FieldName = 'SMTP_SERVER'
          Title.Alignment = taCenter
          Title.Caption = #1055#1086#1095#1090#1086#1074#1099#1081' '#1089#1077#1088#1074#1077#1088
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 127
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SMTP_PORT'
          Title.Alignment = taCenter
          Title.Caption = #1055#1086#1088#1090
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 47
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'USER_LOGIN'
          Title.Alignment = taCenter
          Title.Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 103
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'USER_PASSWORD'
          Title.Alignment = taCenter
          Title.Caption = #1055#1072#1088#1086#1083#1100
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 85
          Visible = True
        end>
    end
  end
  inherited qMain: TOraQuery
    UpdatingTable = ''
    KeyFields = ''
    SQLInsert.Strings = (
      'INSERT INTO SEND_MAIL_PARAMETRES'
      '  (SMTP_SERVER, SMTP_PORT, USER_LOGIN, USER_PASSWORD)'
      'VALUES'
      '  (:SMTP_SERVER, :SMTP_PORT, :USER_LOGIN, :USER_PASSWORD)')
    SQLDelete.Strings = ()
    SQLUpdate.Strings = ()
    SQLRefresh.Strings = (
      'SELECT * '
      'FROM SEND_MAIL_PARAMETRES')
    SQL.Strings = (
      'SELECT * '
      'FROM SEND_MAIL_PARAMETRES')
  end
  inherited qGetNewId: TOraStoredProc
    CommandStoredProcName = 'NEW_DOCUM_TYPE_ID:0'
  end
end
