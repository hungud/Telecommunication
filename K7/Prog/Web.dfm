object FormWeb: TFormWeb
  Left = 0
  Top = 0
  Caption = 'E-care'
  ClientHeight = 457
  ClientWidth = 964
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object wb: TWebBrowser
    Left = 0
    Top = 0
    Width = 964
    Height = 457
    Align = alClient
    TabOrder = 0
    OnDocumentComplete = wbDocumentComplete
    ExplicitWidth = 721
    ExplicitHeight = 385
    ControlData = {
      4C000000A26300003B2F00000000000000000000000000000000000000000000
      000000004C000000000000000000000000000000000000000000000000000000
      0000000008000000000000004C0000000114020000000000C000000000000046
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000100000000000000000000000000000000000000}
  end
  object qNumberinfo: TOraQuery
    DataTypeMap = <>
    SQL.Strings = (
      'select ph.account_id,LI.OBJ_ID,acc.login,acc.new_pswd'
      
        'from db_loader_account_phones ph ,BEELINE_LOADER_INF LI,accounts' +
        ' acc'
      
        'where ph.phone_number=:phone and ph.year_month=to_char(sysdate,'#39 +
        'YYYYMM'#39')'
      'and ph.phone_number=LI.phone_number(+)'
      'and acc.account_id=ph.account_id')
    Left = 288
    Top = 88
    ParamData = <
      item
        DataType = ftString
        Name = 'phone'
        Value = ''
      end>
  end
end
