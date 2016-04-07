object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'ReportHandBlockNumbers'
  ClientHeight = 202
  ClientWidth = 447
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object OraQuery1: TOraQuery
    SQL.Strings = (
      'SELECT C.PHONE_NUMBER_FEDERAL PHONE_NUMBER,'
      '       GET_ABONENT_BALANCE(C.PHONE_NUMBER_FEDERAL) BALANCE,'
      
        '       GET_ACCOUNT_NUMBER_BY_PHONE(C.PHONE_NUMBER_FEDERAL) ACCOU' +
        'NT_NUMBER,'
      '       C.HAND_BLOCK_DATE_END'
      '  FROM CONTRACTS C'
      '  WHERE C.HAND_BLOCK=1'
      '    AND C.HAND_BLOCK_DATE_END>=SYSDATE'
      '    AND C.CONTRACT_ID NOT IN (SELECT CC.CONTRACT_ID'
      '                                FROM CONTRACT_CANCELS CC'
      
        '                                WHERE CC.CONTRACT_ID=C.CONTRACT_' +
        'ID)'
      '  ORDER BY C.HAND_BLOCK_DATE_END ASC')
    Left = 232
    Top = 112
  end
  object DataSource1: TDataSource
    Left = 328
    Top = 136
  end
end
