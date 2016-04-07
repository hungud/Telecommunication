unit NumWithoutTrafficExclusion;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TemplateFrm, ActnList, Menus, DB, MemDS, DBAccess, Ora, Grids,
  DBGrids, CRGrid, ComCtrls, ToolWin, ExtCtrls, Vcl.StdCtrls, Vcl.Buttons, comobj,
  OraSmart, OraTransaction;

type
  TNumWithoutTrafficExclusionFrm = class(TTemplateForm)
    aShowUserStatInfo: TAction;
    ToolButton9: TToolButton;
    aLoadAdd: TAction;
    ToolButton10: TToolButton;
    N7: TMenuItem;
    OpenDialog: TOpenDialog;
    Transaction: TOraTransaction;
    ToolButton11: TToolButton;
    ToolButton12: TToolButton;
    aLoadDelete: TAction;
    procedure qMainBeforePost(DataSet: TDataSet);
    procedure aShowUserStatInfoExecute(Sender: TObject);
    procedure aLoadAddExecute(Sender: TObject);
    procedure aLoadDeleteExecute(Sender: TObject);
    procedure aPostExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses ShowUserStat;

procedure TNumWithoutTrafficExclusionFrm.aLoadAddExecute(Sender: TObject);
var
  Excel: OleVariant;
  i, success, vRes: Integer;
  error:string;
  OraQuery:TOraQuery;
begin
  Try
    error:='';
    success:=0;
    Transaction.StartTransaction;
    if OpenDialog.Execute then
      Try
        OraQuery:=TOraQuery.Create(self);
        Excel := CreateOleObject('Excel.Application');
        Excel.Application.EnableEvents := false;
        Excel.Visible := false;
        Excel.Workbooks.Open(OpenDialog.FileName);
        i := 1;
        while VarToStr(Excel.Cells[i, 1]) <> '' do
        begin
          //проверка
            OraQuery.Close;
            OraQuery.SQL.Text:='SELECT * FROM num_without_traffic_exclusion WHERE phone_number = :phone_number';
            OraQuery.ParamByName('phone_number').AsString := VarToStr(Excel.Cells[i, 1]);
            OraQuery.Open;
            if OraQuery.RecordCount > 0 then
              error := error + VarToStr(Excel.Cells[i, 1]) + ' - уже добавлен в исключения.'#13#10
            else
            try
              OraQuery.Close;
              OraQuery.SQL.Text:='INSERT INTO NUM_WITHOUT_TRAFFIC_EXCLUSION (PHONE_NUMBER) VALUES (:PHONE_NUMBER)';
              OraQuery.ParamByName('phone_number').AsString := VarToStr(Excel.Cells[i, 1]);
              OraQuery.ExecSQL;
              inc(success);
            except
              error := error + VarToStr(Excel.Cells[i, 1]) + ' - ошибка при добавлении.'#13#10;
            end;
            Inc(i);
        end;
      Finally
        OraQuery.Free;
        Excel.Quit;
        Excel := Unassigned;
      end;

    vRes := MessageDlg(error + 'Загружено: ' + inttostr(success) + ' из ' + inttostr(i-1) + #13#10 + 'Сохранить изменения?', mtConfirmation, [mbYes, mbNo], 0);
    if vRes = mrYes then
    begin
      Transaction.Commit;
      aRefresh.Execute;
    end
    else
      Transaction.Rollback;
  Except
    on e: Exception do
    begin
      MessageDlg('Ошибка при загрузке номеров.'#13#10 + e.Message, mtError, [mbOK], 0);
      Transaction.Rollback;
    end;
  End;

end;

procedure TNumWithoutTrafficExclusionFrm.aLoadDeleteExecute(Sender: TObject);
var
  Excel: OleVariant;
  i, success, vRes: Integer;
  error:string;
  OraQuery:TOraQuery;
begin
Try
  error:='';
  success:=0;
  Transaction.StartTransaction;
  if OpenDialog.Execute then
  Try
    OraQuery:=TOraQuery.Create(self);
    Excel := CreateOleObject('Excel.Application');
    Excel.Application.EnableEvents := false;
    Excel.Visible := false;
    Excel.Workbooks.Open(OpenDialog.FileName);
    i := 1;
    while VarToStr(Excel.Cells[i, 1]) <> '' do
    begin
      //проверка
        OraQuery.Close;
        OraQuery.SQL.Text:='SELECT * FROM num_without_traffic_exclusion WHERE phone_number = :phone_number';
        OraQuery.ParamByName('phone_number').AsString:=VarToStr(Excel.Cells[i, 1]);
        OraQuery.Open;
        if OraQuery.RecordCount = 0 then
          error := error + VarToStr(Excel.Cells[i, 1]) + ' - не найден в исключениях.'#13#10
        else
        try
          OraQuery.Close;
          OraQuery.SQL.Text:='DELETE FROM NUM_WITHOUT_TRAFFIC_EXCLUSION WHERE PHONE_NUMBER = :PHONE_NUMBER';
          OraQuery.ParamByName('phone_number').AsString:=VarToStr(Excel.Cells[i, 1]);
          OraQuery.ExecSQL;
          inc(success);
        except
          error := error + VarToStr(Excel.Cells[i, 1]) + ' - ошибка при удалении.'#13#10;
        end;
        Inc(i);
    end;
  Finally
    OraQuery.Free;
    Excel.Quit;
    Excel := Unassigned;
  end;

  vRes := MessageDlg(error + 'Удалено: ' + inttostr(success) + ' из ' + inttostr(i-1) + #13#10 + 'Сохранить изменения?', mtConfirmation, [mbYes, mbNo], 0);
  if vRes = mrYes then
  begin
    Transaction.Commit;
    aRefresh.Execute;
  end
  else
    Transaction.Rollback;
Except
  on e: Exception do
  begin
    MessageDlg('Ошибка при удалении номеров.'#13#10 + e.Message, mtError, [mbOK], 0);
    Transaction.Rollback;
  end;
End;

end;

procedure TNumWithoutTrafficExclusionFrm.aPostExecute(Sender: TObject);
begin
  inherited;
qMain.Refresh;
end;

procedure TNumWithoutTrafficExclusionFrm.aShowUserStatInfoExecute(
  Sender: TObject);
begin
  if qMain.Active and (qMain.RecordCount > 0) then
  begin
    ShowUserStatByPhoneNumber(qMain.FieldByName('phone_number').AsString,0);
  end;
end;

procedure TNumWithoutTrafficExclusionFrm.qMainBeforePost(DataSet: TDataSet);
var
  OraQuery:TOraQuery;
begin
  if DataSet.FieldByName('PHONE_NUMBER').IsNull then
  begin
    MessageDlg('Номер должнен быть заполнен!', mtError, [mbOK], 0);
    Abort;
  end
  else
  begin
    if length(DataSet.FieldByName('PHONE_NUMBER').AsString) > 10 then
    begin
     MessageDlg('Длина номера не более 10 знаков!', mtError, [mbOK], 0);
     Abort;
    end;
    //проверка
    Try
      OraQuery:=TOraQuery.Create(self);
      OraQuery.SQL.Text:='SELECT * FROM num_without_traffic_exclusion WHERE phone_number = :phone_number';
      OraQuery.ParamByName('phone_number').AsString:=DataSet.FieldByName('PHONE_NUMBER').AsString;
      OraQuery.Open;
      if OraQuery.RecordCount > 0 then
      begin
        MessageDlg('Данный номер уже добавлен в исключения.', mtError, [mbOK], 0);
        Abort;
      end;
    Finally
      OraQuery.Free;
    End;
  end;
  inherited;
end;

end.
