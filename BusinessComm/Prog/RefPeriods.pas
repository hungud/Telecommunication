unit RefPeriods;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, RefFrm, Data.DB, MemDS, DBAccess, Ora,  System.StrUtils,
  Vcl.Menus, Vcl.ActnList, Vcl.StdCtrls, Vcl.Buttons, sBitBtn, Vcl.ExtCtrls,   Func_Const, TimedMsgBox,
  sPanel, Vcl.Grids, Vcl.DBGrids, CRGrid, Vcl.ComCtrls, Vcl.ToolWin, ChildFrm, uDm,
  sToolBar;

type
  TRefPeriodsForm = class(TRefForm)
    procedure FormCreate(Sender: TObject);
    procedure aInsertExecute(Sender: TObject);
    procedure qRefDeleteError(DataSet: TDataSet; E: EDatabaseError; var Action: TDataAction);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RefPeriodsForm: TRefPeriodsForm;

implementation

{$R *.dfm}

uses AddPeriod;

procedure TRefPeriodsForm.aInsertExecute(Sender: TObject);
 var
  spf : TChildForm;
begin
  spf := TAddPeriodForm.Create(nil, spf, 'Добавить период', true);
  try
    if spf.ShowModal = mrOk then
    begin
      qGetNewId.StoredProcName := 'INSERT_PERIOD';
      qGetNewId.Prepare;
      qGetNewId.ParamByName('p_YEARS').AsInteger := StrToInt(TAddPeriodForm(spf).ye);
      qGetNewId.ParamByName('p_MONTHS').AsInteger := StrToInt(TAddPeriodForm(spf).mnth);
      qGetNewId.ParamByName('p_YEAR_MONTH').AsInteger := StrToInt(TAddPeriodForm(spf).ye + TAddPeriodForm(spf).mnth);
      qGetNewId.ParamByName('p_IS_ACTIVE').AsInteger := TAddPeriodForm(spf).p_active;
      qGetNewId.Execute;
      qRef.Refresh;
    end;
  finally
    spf.Free;
  end;
end;

procedure TRefPeriodsForm.FormCreate(Sender: TObject);
begin
  qRef := dm.qPeriods;
  inherited;
  qRef.OnDeleteError  := qRefDeleteError;
  //aDelete.Visible := False;
end;

procedure TRefPeriodsForm.qRefDeleteError(DataSet: TDataSet; E: EDatabaseError; var Action: TDataAction);
begin
  if AnsiContainsText(E.Message, 'FK_YEAR_MONTH') then
  begin
    TimedMessageBox('Этот период используется. Удаление невозможно!', 'Пожалуйста, будьте внимательны!', mtWarning, [mbOK], mbOK, 15, 3);
    Action := daAbort;
  end;
end;

end.
