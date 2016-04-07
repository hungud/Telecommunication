unit uShowAnotherVirt_Ac;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ChildFrm, Vcl.Grids, Vcl.DBGrids,
  Data.DB, MemDS, DBAccess, Ora, Vcl.StdCtrls, Vcl.Buttons, sBitBtn,
  Vcl.ExtCtrls, sPanel, sEdit, sLabel, sComboBox;

type
  TShowAnotherVirt_Ac = class(TChildForm)
    sPanel1: TsPanel;
    dsvirtual_operator: TOraDataSource;
    qVirtual_Operator: TOraQuery;
    qVirtual_OperatorVIRTUAL_ACCOUNTS_ID: TFloatField;
    qVirtual_OperatorVIRTUAL_ACCOUNTS_NAME: TStringField;
    qVirtual_OperatorINN: TStringField;
    qVirtual_OperatorVIRTUAL_ACCOUNTS_IS_ACTIVE: TFloatField;
    qVirtual_OperatorCOMMENTS: TStringField;
    DBGrid1: TDBGrid;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    slVirtAcc: TsLabel;
    seVirtAccName_old: TsEdit;
    sLabel1: TsLabel;
    cbVirtAccName_new: TsComboBox;
    Bevel1: TBevel;
    Bevel2: TBevel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure sBsaveClick(Sender: TObject);
    procedure sBCloseClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure qVirtual_OperatorBeforeOpen(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure cbVirtAccName_newChange(Sender: TObject);
  private
    { Private declarations }
  public
   VIRTUAL_ACCOUNTS_ID_OLD, VIRTUAL_ACCOUNTS_ID_NEW : Integer; { Public declarations }
   VIRTUAL_ACCOUNTS_NAME : string;
  end;

var
  ShowAnotherVirt_Ac: TShowAnotherVirt_Ac;

implementation

{$R *.dfm}

procedure TShowAnotherVirt_Ac.cbVirtAccName_newChange(Sender: TObject);
begin
  inherited;
    if cbVirtAccName_new.ItemIndex >= 0 then
      VIRTUAL_ACCOUNTS_ID_NEW := integer(cbVirtAccName_new.Items.Objects[cbVirtAccName_new.ItemIndex]);
end;

procedure TShowAnotherVirt_Ac.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  qVirtual_Operator.close;
end;

procedure TShowAnotherVirt_Ac.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
 // inherited;
   CanClose := True;
end;

procedure TShowAnotherVirt_Ac.FormShow(Sender: TObject);
begin
  inherited;
    qVirtual_Operator.Open;
    seVirtAccName_old.Text := VIRTUAL_ACCOUNTS_NAME;

    while not qVirtual_Operator.EOF do
    begin

      cbVirtAccName_new.Items.AddObject(qVirtual_Operator.FieldByName('VIRTUAL_ACCOUNTS_NAME').AsString, TObject(qVirtual_Operator.FieldByName('VIRTUAL_ACCOUNTS_ID').Asinteger));
      qVirtual_Operator.Next;
    end;
    if cbVirtAccName_new.Items.Count > 0 then
      cbVirtAccName_new.ItemIndex := 0;
    if cbVirtAccName_new.ItemIndex >= 0 then
      VIRTUAL_ACCOUNTS_ID_NEW := integer(cbVirtAccName_new.Items.Objects[cbVirtAccName_new.ItemIndex]);
end;

procedure TShowAnotherVirt_Ac.qVirtual_OperatorBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  qVirtual_Operator.ParamByName('VIRTUAL_ACCOUNTS_ID').AsInteger := VIRTUAL_ACCOUNTS_ID_OLD;
end;

procedure TShowAnotherVirt_Ac.sBCloseClick(Sender: TObject);
begin
  inherited;
  close;
end;

procedure TShowAnotherVirt_Ac.sBsaveClick(Sender: TObject);
begin
  inherited;
    VIRTUAL_ACCOUNTS_ID_NEW := qVirtual_Operator.FieldByName('VIRTUAL_ACCOUNTS_ID').AsInteger;
    ModalResult:=  mrOk;
    close;

end;

end.
