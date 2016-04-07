unit ShowPayments;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, MemDS, DBAccess, Ora, ActnList, Grids, DBGrids, CRGrid, StdCtrls,
  Buttons, ExtCtrls, Menus,oraerror;

type
  TShowPaymentsForm = class(TForm)
    grData: TCRDBGrid;
    dsReport: TDataSource;
    qreport: TOraQuery;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
 ShowPaymentsForm: TShowPaymentsForm;

procedure DoShowPayments(account_id:integer;date_balance:tdatetime);

implementation

{$R *.dfm}

uses ContractsRegistration_Utils, Main;

procedure DoShowPayments(account_id:integer;date_balance:tdatetime);
var ReportFrm : TShowPaymentsForm;
    Sdvig:integer;
begin
  ReportFrm:=TShowPaymentsForm.Create(Nil);
  try
    ReportFrm.qReport.ParamByName('account_id').AsInteger:=account_id;
    ReportFrm.qReport.ParamByName('date_balance').AsDateTime:=date_balance;
    ReportFrm.qReport.Open;
    ReportFrm.ShowModal;
  finally
    ReportFrm.Free;
  end;
end;





end.


