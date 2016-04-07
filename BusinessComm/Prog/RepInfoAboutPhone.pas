unit RepInfoAboutPhone;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ChildFrm, uDm, Func_Const, TimedMsgBox,
  Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls, Data.DB, DBAccess, Ora, MemDS;

type
  TRepInfoAboutPhoneFrm = class(TChildForm)
    qPhonesForAccount: TOraQuery;
    qPhonesForAccountPHONE_ON_ACCOUNTS_ID: TFloatField;
    qPhonesForAccountACCOUNT_ID: TFloatField;
    qPhonesForAccountPHONE_NUMBER: TStringField;
    qPhonesForAccountPHONE_NUMBER_CITY: TStringField;
    qPhonesForAccountPHONE_IS_ACTIVE: TFloatField;
    qPhonesForAccountPHONE_IS_ACTIVE_STR: TStringField;
    qPhonesForAccountACCOUNT_NUMBER: TFloatField;
    qPhonesForAccountMOBILE_OPERATOR_NAME: TStringField;
    qPhonesForAccountLOGIN: TStringField;
    dsqPhonesForAccount: TOraDataSource;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    dbchkPHONE_IS_ACTIVE: TDBCheckBox;
    dbedtPHONE_NUMBER: TDBEdit;
    dbedtMOBILE_OPERATOR_NAME: TDBEdit;
    dbedtPHONE_NUMBER_CITY: TDBEdit;
    dbedtACCOUNT_NUMBER: TDBEdit;
    dbedtLOGIN: TDBEdit;
    //procedure FormCreate(Sender: TObject);
    procedure SetFindUser( Value : TFindUser);
    procedure qPhonesForAccountBeforeOpen(DataSet: TDataSet);
  private
    { Private declarations }
   fFindUser:TFindUser;
  public
    { Public declarations }
  published
    property FndUser: TFindUser read fFindUser write SetFindUser;
  end;

var
  RepInfoAboutPhoneFrm: TRepInfoAboutPhoneFrm;

procedure DoShowInfoAboutPhone(FindUser: TFindUser);

implementation

{$R *.dfm}

procedure DoShowInfoAboutPhone(FindUser:TFindUser);
var
  RepInfo : TChildForm;
begin
  if (FindUser.PHONE_ID <> null) then
  begin
    RepInfo := TRepInfoAboutPhoneFrm.Create(nil, RepInfo, 'Информация по номеру - ' + IntToStr(FindUser.PHONE_ID), True);
    TRepInfoAboutPhoneFrm(RepInfo).FndUser := FindUser;
    try
      TRepInfoAboutPhoneFrm(RepInfo).ShowModal;
    finally
      TRepInfoAboutPhoneFrm(RepInfo).Free;
    end;
  end else begin
    if Dm.DebugMode then
      TimedMessageBox('Не указан телефонный номер!','Пожалуйста, будьте внимательны!', mtError, [mbOK], mbOK, 25, 3);
  end;
end;

procedure TRepInfoAboutPhoneFrm.qPhonesForAccountBeforeOpen(DataSet: TDataSet);
begin
  inherited;
 qPhonesForAccount.ParamByName('PHONE_ID').AsInteger := fFindUser.PHONE_ID;
end;

procedure TRepInfoAboutPhoneFrm.SetFindUser(Value: TFindUser);
begin
  inherited;
  fFindUser := Value;
  Caption := Caption + '; телефон - ' + IntToStr(fFindUser.PHONE_ID);
  qPhonesForAccount.Open;
end;

end.
