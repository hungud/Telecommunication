object MonitorEv: TMonitorEv
  Left = 0
  Top = 0
  Caption = #1052#1086#1085#1080#1090#1086#1088#1080#1085#1075' '#1089#1086#1073#1099#1090#1080#1081
  ClientHeight = 419
  ClientWidth = 749
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object StringGrid1: TStringGrid
    Left = 0
    Top = 0
    Width = 749
    Height = 419
    Align = alClient
    ColCount = 3
    FixedCols = 0
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
    TabOrder = 0
    OnDrawCell = StringGrid1DrawCell
  end
  object DataSource1: TDataSource
    DataSet = OraQuery1
    Left = 504
    Top = 320
  end
  object OraQuery1: TOraQuery
    DataTypeMap = <>
    Session = MainForm.OraSession
    SQL.Strings = (
      'select * from V_MONITOR_STRINGS_MAT')
    Left = 424
    Top = 320
  end
  object TimerMonitor: TTimer
    Enabled = False
    Interval = 60000
    OnTimer = TimerMonitorTimer
    Left = 304
    Top = 152
  end
end
