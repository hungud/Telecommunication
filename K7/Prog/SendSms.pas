unit SendSms;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, MemDS, DBAccess, Ora, StdCtrls, DBCtrls;

type
  TSendSmsFrm = class(TForm)

    BtSendSms: TButton;
    spLoaderSendSms: TOraStoredProc;
    TEdMailingName: TEdit;
    MTextSms: TMemo;
    Label1: TLabel;
    Label3: TLabel;
    BtSendSmsClose: TButton;
    procedure BtSendSmsClick(Sender: TObject);



  private
    { Private declarations }



    FMailingName :string;
    FSmsText: string;
  public
    FPhoneNumber : String;
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TSendSmsFrm.BtSendSmsClick(Sender: TObject);
var
  DetailText : String;

begin
  FMailingName:=TEdMailingName.Text;
  FSmsText:=MTextSms.Text;
  spLoaderSendSms.ParamByName('pPHONE_NUMBER').AsString :=FPhoneNumber;
  spLoaderSendSms.ParamByName('pMAILING_NAME').AsString := FMailingName;
  spLoaderSendSms.ParamByName('pSMS_TEXT').AsString := FSmsText;
  try
    spLoaderSendSms.ExecProc;
    DetailText := spLoaderSendSms.ParamByName('RESULT').AsString;
  except
    on E : Exception do
    begin
      DetailText := 'Ошибка отправки сообщения.'#13#10 + E.Message;
    end;
  end;
  if DetailText='' then
    ShowMessage('Операция выполнена успешно')
  else
    MessageDlg(DetailText, mtWarning, [mbOk], 0);
end;
end.
