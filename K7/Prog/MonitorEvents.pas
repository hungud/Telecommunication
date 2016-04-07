unit MonitorEvents;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.DBGrids, Data.DB, MemDS,
  DBAccess, Ora, Vcl.ExtCtrls;

type
  TMonitorEv = class(TForm)
    DataSource1: TDataSource;
    OraQuery1: TOraQuery;
    StringGrid1: TStringGrid;
    TimerMonitor: TTimer;
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure TimerMonitorTimer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Monitoring;
  end;

var
  MonitorEv: TMonitorEv;

implementation

{$R *.dfm}

uses Main;

procedure TMonitorEV.Monitoring;
var i : integer;
  x, y, w: integer;
  s: string;
  MaxWidth: integer;
begin
oraquery1.Close;
  oraquery1.Active:=TRUE;
  i:=0;
  oraquery1.FindFirst;
  StringGrid1.Cells[0,0]:='Событие';
  StringGrid1.Cells[1,0]:='Показатель';
  StringGrid1.Cells[2,0]:='Статус';
  stringGrid1.RowCount:=oraquery1.RecordCount+1;
  while i <> oraquery1.RecordCount do
    begin
      stringGrid1.Cells[0,i+1]:=Oraquery1.FieldByName('DAT').AsString;
      stringGrid1.Cells[1,i+1]:=Oraquery1.FieldByName('ERR').AsString;
      stringGrid1.Cells[2,i+1]:=Oraquery1.FieldByName('COLOR').AsString;
      inc(i);
      oraquery1.FindNext;
    end;
  with StringGrid1 do
    ClientHeight := DefaultRowHeight * RowCount + 5;
    with StringGrid1 do
    begin
      for x := 0 to ColCount - 1 do
      begin
        MaxWidth := 0;
        for y := 0 to RowCount - 1 do
        begin
          w := Canvas.TextWidth(Cells[x,y]);
          if w > MaxWidth then
            MaxWidth := w;
        end;
        ColWidths[x] := MaxWidth + 5;
      end;
    end;
end;

procedure TMonitorEv.FormActivate(Sender: TObject);
begin
  Monitoring;
  TimerMonitor.Enabled:=true;
  // актив
end;

procedure TMonitorEv.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  TimerMonitor.Enabled:=false;
  MainForm.IsMonitorEvRun:=false;
  Action:=caFree;
end;

procedure TMonitorEv.StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
begin
      if StringGrid1.Cells[ACol,ARow]='GREEN' then
        begin
          StringGrid1.Canvas.Brush.Color:=clGreen;
          StringGrid1.Canvas.FillRect(Rect);
          //StringGrid1.Canvas.TextOut(Rect.Left,Rect.Top,StringGrid1.Cells[ACol,ARow]);
        end
      else
        if StringGrid1.Cells[ACol,ARow]='YELLOW' then
          begin
            StringGrid1.Canvas.Brush.Color:=clYellow;
            StringGrid1.Canvas.FillRect(Rect);
            //StringGrid1.Canvas.TextOut(Rect.Left,Rect.Top,StringGrid1.Cells[ACol,ARow]);
          end
        else
          if StringGrid1.Cells[ACol,ARow]='RED' then
            begin
              StringGrid1.Canvas.Brush.Color:=clRed;
              StringGrid1.Canvas.FillRect(Rect);
              //StringGrid1.Canvas.TextOut(Rect.Left,Rect.Top,StringGrid1.Cells[ACol,ARow]);
            end;
end;

procedure TMonitorEv.TimerMonitorTimer(Sender: TObject);
begin
  Monitoring;
end;

end.
