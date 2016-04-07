unit RecommendedTariffOptions;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, MemDS, DBAccess, Ora, ActnList, Grids, DBGrids, CRGrid, StdCtrls,
  Buttons, ExtCtrls, Menus, oraerror, Vcl.ComCtrls, sListBox, sCheckListBox;

type
  TRecommendedTariffOptionsForm = class(TForm)
    Panel1: TPanel;
    Splitter1: TSplitter;
    Panel2: TPanel;
    Panel3: TPanel;
    clbAllow: TsCheckListBox;
    clbRecommended: TsCheckListBox;
    btnAdd: TBitBtn;
    btnDelete: TBitBtn;
    qRecommended: TOraQuery;
    qAllow: TOraQuery;
    qChange: TOraQuery;
    Panel4: TPanel;
    Label1: TLabel;
    Panel5: TPanel;
    Label2: TLabel;
    procedure btnAddClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
  private
    { Private declarations }
    Tariff_id: integer;
    DefSpisok : TsCheckListBox;
    procedure refresh;
  public
    { Public declarations }
  end;

var
 RecommendedTariffOptionsForm: TRecommendedTariffOptionsForm;

procedure DoRecommendedTariffOptions(pTariff_id: integer; pTariff_Name: string);

implementation

{$R *.dfm}

uses ContractsRegistration_Utils, dmUnit;

procedure TRecommendedTariffOptionsForm.btnAddClick(Sender: TObject);
var
  i:integer;
begin
  dm.OraSession.StartTransaction;
  Try
    for I := 0 to clbAllow.Count-1 do
      if clbAllow.Checked[i] then
      begin
        qChange.Close;
        qChange.SQL.Text:='INSERT INTO recommended_tariff_options (tariff_id, tariff_option_id) VALUES (:tariff_id, :tariff_option_id)';
        qChange.ParamByName('tariff_id').AsInteger:=Tariff_id;
        qChange.ParamByName('tariff_option_id').AsInteger:=Integer(clbAllow.Items.Objects[i]);
        qChange.ExecSQL;
      end;
    dm.OraSession.Commit;
  Except
   on e : exception do
   begin
     Dm.OraSession.Rollback;
     MessageDlg('Ошибка добавления опций в рекомендуемые.'#13#10 + e.Message, mtError, [mbOK], 0);
   end;
  End;
  refresh;
end;

procedure TRecommendedTariffOptionsForm.btnDeleteClick(Sender: TObject);
var
  i:integer;
begin
  dm.OraSession.StartTransaction;
  Try
    for I := 0 to clbRecommended.Count-1 do
      if clbRecommended.Checked[i] then
      begin
        qChange.Close;
        qChange.SQL.Text:='DELETE FROM recommended_tariff_options WHERE tariff_id = :tariff_id AND tariff_option_id = :tariff_option_id';
        qChange.ParamByName('tariff_id').AsInteger:=Tariff_id;
        qChange.ParamByName('tariff_option_id').AsInteger:=Integer(clbRecommended.Items.Objects[i]);
        qChange.ExecSQL;
      end;
    dm.OraSession.Commit;
  Except
   on e : exception do
   begin
     Dm.OraSession.Rollback;
     MessageDlg('Ошибка удаления опций из рекомендуемых.'#13#10 + e.Message, mtError, [mbOK], 0);
   end;
  End;
  refresh;
end;

procedure TRecommendedTariffOptionsForm.refresh;
begin
  Try
    qRecommended.ParamByName('TARIFF_ID').AsInteger:=Tariff_id;
    qRecommended.Open;
    clbRecommended.Items.Clear;
    while not qRecommended.EOF do
    begin
      clbRecommended.Items.AddObject(
        qRecommended.FieldByName('OPTION_NAME').AsString + ' - ('
          + qRecommended.FieldByName('OPTION_CODE').AsString + ')',
        TObject(qRecommended.FieldByName('TARIFF_OPTION_ID').AsInteger)
        );
      qRecommended.Next;
    end;
  Finally
     qRecommended.Close;
  End;
  Try
    qAllow.ParamByName('TARIFF_ID').AsInteger:=Tariff_id;
    qAllow.Open;
    clbAllow.Items.Clear;
    while not qAllow.EOF do
    begin
      clbAllow.Items.AddObject(
        qAllow.FieldByName('OPTION_NAME').AsString + ' - ('
          + qAllow.FieldByName('OPTION_CODE').AsString + ')',
        TObject(qAllow.FieldByName('TARIFF_OPTION_ID').AsInteger)
        );
      qAllow.Next;
    end;
  Finally
     qAllow.Close;
  End;

end;

procedure DoRecommendedTariffOptions(pTariff_id: integer; pTariff_Name: string);
var ReportFrm : TRecommendedTariffOptionsForm;
begin
  ReportFrm:=TRecommendedTariffOptionsForm.Create(Nil);
  try
    with ReportFrm do begin
      Tariff_id:=pTariff_id;
      Caption:=Caption + ' - ' +  pTariff_Name;
      refresh;
      ShowModal;
    end;
  finally
    ReportFrm.Free;
  end;
end;



end.


