unit DMUnit;

interface

uses
  System.SysUtils, System.Classes, Data.DB, MemDS, DBAccess, Ora;

type
  TDM = class(TDataModule)
    qFormAccess: TOraQuery;
    qMenuAccess: TOraQuery;
    qAccounts: TOraQuery;
    qPeriods: TOraQuery;
    dsPeriods: TDataSource;
    DS_Rep: TDataSource;
    qReport: TOraQuery;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DM: TDM;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

end.
