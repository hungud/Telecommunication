unit RefPhonesWithDailyAbon;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, TemplateFrm, Ora, Vcl.ActnList,
  Vcl.Menus, Data.DB, MemDS, DBAccess, Vcl.Grids, Vcl.DBGrids, CRGrid,
  Vcl.ComCtrls, Vcl.ToolWin, Vcl.ExtCtrls;

type
  TPhonesWithDailyAbonForm = class(TTemplateForm)
    qMainPHONE_NUMBER: TStringField;
    qMainUSER_LAST_UPDATE: TStringField;
    qMainDATE_LAST_UPDATE: TDateTimeField;
    procedure qMainBeforePost(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }

  end;
  procedure DoPhoneNumberWithDailyAbon;
var
  PhonesWithDailyAbonForm: TPhonesWithDailyAbonForm;

implementation

uses
  Main;

{$R *.dfm}
 procedure DoPhoneNumberWithDailyAbon;
var ReportFrm : TPhonesWithDailyAbonForm;
    Sdvig:integer;
begin
  ReportFrm:=TPhonesWithDailyAbonForm.Create(Nil);
  ReportFrm.qMain.Open;
  try
    // Отчет
    ReportFrm.ShowModal;
  finally
    ReportFrm.Free;
  end;
end;

procedure TPhonesWithDailyAbonForm.FormCreate(Sender: TObject);
begin

  if MainForm.FUseFilialBlockAccess then
    qMain.SQL.Append('WHERE GET_FILIAL_ID_BY_PHONE(PHONE_NUMBER) = ' + IntToStr(MainForm.FFilial));
ToolButton4.Enabled:=False;
ToolButton5.Enabled:=False;
end;

procedure TPhonesWithDailyAbonForm.qMainBeforePost(DataSet: TDataSet);
begin
  //inherited;

end;

end.
