unit ReportAPIRejectBlocks;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, MemDS, DBAccess, Ora,
  Vcl.Grids, Vcl.DBGrids, CRGrid, Vcl.ExtCtrls, Main, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ComCtrls, Vcl.DBCtrls;

type
  TReportAPIRejectBlocksForm = class(TForm)
    p1: TPanel;
    dsReportAPIRejectBlocks: TDataSource;
    qReportAPIRejectBlocks: TOraQuery;
    pFilter: TPanel;
    lbl1: TLabel;
    lbl2: TLabel;
    dtDateBegin: TDateTimePicker;
    dtDateEnd: TDateTimePicker;
    btRefresh: TBitBtn;
    lbl3: TLabel;
    lbl4: TLabel;
    dblkcbbTICKET_TYPES: TDBLookupComboBox;
    dblkcbbAnswerType: TDBLookupComboBox;
    dsTICKET_TYPES: TDataSource;
    qTICKET_TYPES: TOraQuery;
    p2: TPanel;
    gApiRejectBlocks: TCRDBGrid;
    qAnswerTypes: TOraQuery;
    dsAnswerTypes: TDataSource;
    btLoadInExcel: TBitBtn;
    procedure btRefreshClick(Sender: TObject);
    procedure dtDateBeginChange(Sender: TObject);
    procedure dtDateEndChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dsTICKET_TYPESDataChange(Sender: TObject; Field: TField);
    procedure dsAnswerTypesDataChange(Sender: TObject; Field: TField);
    procedure btLoadInExcelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


var
  ReportAPIRejectBlocksForm: TReportAPIRejectBlocksForm;
  procedure DoReportAPIRejectBlocks;

implementation

uses IntecExportGrid;
//uses
//  Main;

procedure DoReportAPIRejectBlocks;
var
  ReportFrm : TReportAPIRejectBlocksForm;
begin
  ReportFrm := TReportAPIRejectBlocksForm.Create(Nil);
  try
    // Заполнение списка заявок
    with ReportFrm do begin
      qReportAPIRejectBlocks.ParamByName('pDATE_BEGIN').AsDate := dtDateBegin.Date;
      qReportAPIRejectBlocks.ParamByName('pDATE_END').AsDate := dtDateEnd.Date;

      qReportAPIRejectBlocks.Open;
      qReportAPIRejectBlocks.First;
      qReportAPIRejectBlocks.Close;

      qTICKET_TYPES.Close;
      qTICKET_TYPES.Open;
      dblkcbbTICKET_TYPES.KeyValue := -1;

      qAnswerTypes.Close;
      qAnswerTypes.Open;
      dblkcbbAnswerType.KeyValue := -1;

      ShowModal;
    end;
  finally
    ReportFrm.Free;
  end;
end;
{$R *.dfm}

procedure TReportAPIRejectBlocksForm.btLoadInExcelClick(Sender: TObject);
var cr : TCursor;
begin
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    ExportDBGridToExcel2('Отчет по отклоненным блокировкам/разблокировкам через API за период','',
      gApiRejectBlocks, nil, False, True);
  finally
    Screen.Cursor := cr;
  end;
end;

procedure TReportAPIRejectBlocksForm.btRefreshClick(Sender: TObject);
begin
  qReportAPIRejectBlocks.Close;
  qReportAPIRejectBlocks.Open;
end;

procedure TReportAPIRejectBlocksForm.dsAnswerTypesDataChange(Sender: TObject;
  Field: TField);
begin
  qReportAPIRejectBlocks.ParamByName('pANSWER_TYPE_ID').AsInteger := qAnswerTypes.FieldByName('ANSWER_TYPE_ID').AsInteger;
end;

procedure TReportAPIRejectBlocksForm.dsTICKET_TYPESDataChange(Sender: TObject;
  Field: TField);
begin
  qReportAPIRejectBlocks.ParamByName('pTICKET_TYPE_ID').AsInteger := qTICKET_TYPES.FieldByName('TICKET_TYPE_ID').AsInteger;
end;

procedure TReportAPIRejectBlocksForm.dtDateBeginChange(Sender: TObject);
begin
  qReportAPIRejectBlocks.ParamByName('pDATE_BEGIN').AsDate := dtDateBegin.Date;
end;

procedure TReportAPIRejectBlocksForm.dtDateEndChange(Sender: TObject);
begin
  qReportAPIRejectBlocks.ParamByName('pDATE_END').AsDate := dtDateEnd.Date;
end;

procedure TReportAPIRejectBlocksForm.FormCreate(Sender: TObject);
begin
  // КАК ПРАВИЛО БЕРЕМ ЗА ПРОШЕДШИЕ СУТКИ
  dtDateBegin.Date := (Date - 1);
  dtDateEnd.Date := Date;
end;

end.
