unit ReportTariferPayments;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, CRGrid, DB, MemDS, DBAccess, Ora;

type
  TReportTariferPaymentsForm = class(TForm)
    OraQuery1: TOraQuery;
    DataSource1: TDataSource;
    CRDBGrid1: TCRDBGrid;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ReportTariferPaymentsForm: TReportTariferPaymentsForm;

implementation

{$R *.dfm}

end.
