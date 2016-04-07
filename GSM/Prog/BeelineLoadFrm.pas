unit BeelineLoadFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, DBCtrls, DB,Buttons, MemDS, DBAccess, Ora, ComCtrls,
  ActiveX, IntecExportGrid, StrUtils;

type
  TBeelineLoadForm = class(TForm)
    mData: TMemo;
    Panel1: TPanel;
    pAccountCaption: TPanel;
    lbAccount: TListBox;
    pPeriodCaption: TPanel;
    lbPeriods: TListBox;
    Panel4: TPanel;
    btnLoad: TButton;
    qAccounts: TOraQuery;
    pProgress: TProgressBar;
    dgOpen: TOpenDialog;
    BitBtn2: TBitBtn;
    dsContarct: TDataSource;
    qContract: TOraQuery;
    qGetNewId: TOraStoredProc;
    qContractCancel: TOraQuery;
    dsContractCancel: TDataSource;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    CONTRACT_CANCEL_DATE: TDateTimePicker;
    BitBtn1: TBitBtn;
    qChangeDS: TOraQuery;
    procedure btnLoadClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FHeaderLineIndex: Integer;
    countclosecontract:Integer;

  protected
    FAccountID : Integer;
    FAbonentID : Integer;
    FContractID : Integer;
    FAccountLogin : String;
    FLoadingYear, FLoadingMonth : Integer;

    function MakeStoredProcedure(const AText : String) : TOraStoredProc;
    function GetFloatData(const Value: string): Double;
    function GetIntegerData(const Value: string): Integer;


    function GetHeaderLine : String; virtual; abstract;
    function GetFormCaption : String; virtual; abstract;
    function IsSelectPeriodEnabled : Boolean; virtual;
    function IsSelectAccountEnabled : Boolean; virtual;
    //
    procedure DoBeforeLoad; virtual; abstract;
    procedure DoFormCreate; virtual; abstract;
    procedure DoLoad(var Line : String); virtual; abstract;
    procedure DoAfterLoad; virtual; abstract;
  public
     fFilialId : integer;
    procedure Execute;
  end;

   TBeelineLoadCloseForm = class(TBeelineLoadForm)
  private
    FLoadProc : TOraStoredProc;
  protected
    function GetHeaderLine : String; override;
    function GetFormCaption : String; override;
    function IsSelectPeriodEnabled : Boolean; override;
    function IsSelectAccountEnabled : Boolean; override;
    //
    procedure DoBeforeLoad; override;
    procedure DoFormCreate;  override;
    procedure DoLoad(var Line : String); override;
    procedure DoAfterLoad; override;
  end;

  TBeelineLoadBSForm = class(TBeelineLoadForm)
  private
    FLoadProc : TOraStoredProc;
  protected
    function IsSelectPeriodEnabled : Boolean; override;
    function IsSelectAccountEnabled : Boolean; override;
    //
    procedure DoBeforeLoad; override;
    procedure DoFormCreate;  override;
    procedure DoLoad(var Line : String); override;
    procedure DoAfterLoad; override;

    function GetZoneName : String; virtual; abstract;
  end;

   TBeelineLoadDopPhoneInfo = class(TBeelineLoadForm)
  private
    FLoadProc : TOraStoredProc;
  protected
    function GetHeaderLine : String; override;
    function GetFormCaption : String; override;
    function IsSelectPeriodEnabled : Boolean; override;
    function IsSelectAccountEnabled : Boolean; override;
    //
    procedure DoBeforeLoad; override;
    procedure DoFormCreate;  override;
    procedure DoLoad(var Line : String); override;
    procedure DoAfterLoad; override;

  end;


implementation
uses ComObj, Main, CRStrUtils, ContractsRegistration_Utils;

{$R *.dfm}

{ TBeelineLoadForm }

procedure TBeelineLoadForm.BitBtn1Click(Sender: TObject);
var cr : TCursor;
begin
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    ExportStringsToExcel(mdata.Lines,GetFormCaption,#9);
  finally
    Screen.Cursor := cr;
  end;
end;



procedure TBeelineLoadForm.btnLoadClick(Sender: TObject);
var
  i: Integer;
  s :string;
  PeriodStamp: Integer;
  vStringList : TStringList;
begin
  if lbAccount.Items.Count > 0 then
  begin
    FAccountID := Integer(lbAccount.Items.Objects[lbAccount.ItemIndex]);
    FAccountLogin := lbAccount.Items[lbAccount.ItemIndex];
  end
  else
  begin
    FAccountID := -1;
    FAccountLogin := '';
  end;
  if IsSelectPeriodEnabled then
  begin
    PeriodStamp := Integer(lbPeriods.Items.Objects[lbPeriods.ItemIndex]);;
    FLoadingYear := PeriodStamp div 100;
    FLoadingMonth := PeriodStamp - FLoadingYear*100;
  end;
  Screen.Cursor := crSQLWait;
  try
    MainForm.OraSession.StartTransaction;
    DoBeforeLoad;
    pProgress.Max := mData.Lines.Count-1;
    vStringList := TStringList.Create;
    LockWindowUpdate(mData.Handle);
    for i := FHeaderLineIndex+1 to mData.Lines.Count-1 do
    begin
      pProgress.Position := i;
      pProgress.Update;
      Application.ProcessMessages;
      s := mData.Lines[i];
      DoLoad(s);
      vStringList.Add(s);
//      mData.Lines[i]:=s;
    end;
    mData.Lines := vStringList;
    vStringList.Free;
    LockWindowUpdate(0);
    DoAfterLoad;
    MainForm.OraSession.Commit;
    Screen.Cursor := crDefault;
    btnLoad.Enabled := False;
    ShowMessage('Загрузка выполнена!');
  except
    Screen.Cursor := crDefault;
    MainForm.OraSession.Rollback;
    Raise;
  end;
end;


procedure TBeelineLoadForm.Execute;
var
  FileName: TFileName;
  fs : TFileStream;
  Parser: Variant;
  ParsedArray: Variant;
  ms: TBytesStream;
  VarBytes : Variant;
  TextData: String;
  I: Integer;
  ADate: TDateTime;
  StreamAdapter : TStreamAdapter;
  dd: Word;
  mm: Word;
  yy: Word;
  HeaderLine: string;
begin
  Caption := GetFormCaption;
  dgOpen.Title := Caption;
  if dgOpen.Execute then
  begin
    FileName := dgOpen.FileName;
    ms := TBytesStream.Create;
    try
      fs := TFileStream.Create(FileName, fmOpenRead or fmShareDenyNone);
      try
        ms.CopyFrom(fs, 0);
      finally
        FreeAndNil(fs);
      end;
      VarBytes := ms.Bytes;
    finally
      FreeAndNil(ms);
    end;
    try
      Parser := CreateOleObject('TariferPreProcessor.PreProcessor');
    except
      ShowMessage('Нужно зарегистрировать TariferPreProcessor.dll. Наберите в командной строке:'#13#10'regsvr32 TariferPreProcessor.dll');
      VarClear(Parser);
    end;
    if not VarIsEmpty(Parser) then
    begin
    try
      ParsedArray := Parser.ProcessData(VarBytes);
    except
      VarClear(Parser);
      VarClear(ParsedArray);
      try
        fs := TFileStream.Create(FileName, fmOpenRead or fmShareDenyNone);
        Parser := CreateOleObject('TariferPreProcessor.PreProcessExcelFull');
        StreamAdapter := TStreamAdapter.Create(Fs, soReference);
        ParsedArray := Parser.ProcessData(StreamAdapter as IStream);
      finally
         FreeAndNil(fs);
      end;
    end;
      if VarIsArray(ParsedArray) and (VarArrayHighBound(ParsedArray, 1) >= 0) then
        TextData := ParsedArray[0]
      else
        TextData := '';
      mData.Lines.Text := TextData;
      if TextData = '' then
      begin
        btnLoad.Enabled := False;
        ShowMessage('Файл не содержит информации. Загрузка не разрешена.');
      end
      else
      begin
        HeaderLine := GetHeaderLine;
        FHeaderLineIndex := mData.Lines.IndexOf(HeaderLine);
        if FHeaderLineIndex < 0 then
        begin
          btnLoad.Enabled := False;
          ShowMessage('Формат файла не соответствует шаблону:'#13#10#13#10 + HeaderLine + #13#10#13#10'Загрузка не разрешена.');
        end
        else
        begin
          if IsSelectAccountEnabled then
          begin
            qAccounts.Open;
            try
              while not qAccounts.Eof do
              begin
                lbAccount.AddItem(
                  qAccounts.FieldByName('LOGIN').AsString,
                  Pointer(qAccounts.FieldByName('ACCOUNT_ID').AsInteger)
                  );
                qAccounts.Next;
              end;
            finally
              qAccounts.Close;
            end;
            if lbAccount.Items.Count > 0 then
              lbAccount.ItemIndex := 0;
            btnLoad.Enabled := (lbAccount.Items.Count > 0);
          end
          else
          begin
            pAccountCaption.Hide;
            lbAccount.Hide;
            btnLoad.Enabled := True;
          end;
          if IsSelectPeriodEnabled then
          begin
            for I := 0 to 11 do
            begin
              ADate := IncMonth(Date, -I);
              DecodeDate(ADate, yy, mm ,dd);
              lbPeriods.AddItem(FormatDateTime('YYYY, MM', ADate), Pointer(yy*100+mm));
            end;
            lbPeriods.ItemIndex := 0;
          end
          else
          begin
            pPeriodCaption.Hide;
            lbPeriods.Hide;
          end;
        end;
      end;
      ShowModal;
    end;
  end;
end;

procedure TBeelineLoadForm.FormCreate(Sender: TObject);
begin
  DoFormCreate;
end;

function TBeelineLoadForm.MakeStoredProcedure(
  const AText: String): TOraStoredProc;
begin
  Result := TOraStoredProc.Create(Self);
  Result.StoredProcName := AText;
//  Result.SQL.Text := AText;
  Result.Prepared := True;
end;

function TBeelineLoadForm.IsSelectPeriodEnabled: Boolean;
begin
  Result := True;
end;


function TBeelineLoadForm.GetFloatData(const Value: string): Double;
begin
  Result := StrToFloat(
    StringReplace(
      StringReplace(
        StringReplace(
          StringReplace(Value, ' ', '', [rfReplaceAll]),
           ' ', '', [rfReplaceAll]),
         ',', DecimalSeparator, [rfReplaceAll]),
       '.', DecimalSeparator, [rfReplaceAll])
    );
end;

function TBeelineLoadForm.GetIntegerData(const Value: string): Integer;
begin
  Result := StrToInt(
    StringReplace(
      StringReplace(
        StringReplace(
          StringReplace(Value, ' ', '', [rfReplaceAll]),
           ' ', '', [rfReplaceAll]),
         ',', DecimalSeparator, [rfReplaceAll]),
       '.', DecimalSeparator, [rfReplaceAll])
    );
end;

function TBeelineLoadForm.IsSelectAccountEnabled: Boolean;
begin
  Result := True;
end;

{ TBeelineLoadBS_Msk_Form }

procedure TBeelineLoadBSForm.DoBeforeLoad;
begin
  FLoadProc := MakeStoredProcedure('BEELINE_BS_ZONE_CLEAR');
  FLoadProc.ParamByName('pZONE_NAME').AsString := GetZoneName;
  FLoadProc.Execute;
  FreeAndNil(FLoadProc);
  // Nothing
end;

procedure TBeelineLoadBSForm.DoAfterLoad;
begin
  FreeAndNil(FLoadProc);
end;

function TBeelineLoadBSForm.IsSelectAccountEnabled: Boolean;
begin
  Result := False;
end;

procedure TBeelineLoadBSForm.DoLoad(var Line: String);
var
  BSCode: Integer;
begin
  BSCode := StrToIntDef(GetToken(Line, 1, #9), -1);
  if BSCode > 0 then
  begin
    if FLoadProc = nil then
    begin
      FLoadProc := MakeStoredProcedure('BEELINE_BS_ZONE_ADD_CODE');
      FLoadProc.ParamByName('pZONE_NAME').AsString := GetZoneName;
    end;
    FLoadProc.ParamByName('pBS_CODE').AsInteger := BSCode;
    FLoadProc.ExecSQL;
  end;
end;

function TBeelineLoadBSForm.IsSelectPeriodEnabled: Boolean;
begin
  Result := False;
end;

procedure TBeelineLoadCloseForm.DoFormCreate;
begin

end;

procedure TBeelineLoadBSForm.DoFormCreate;
begin

end;


procedure TBeelineLoadDopPhoneInfo.DoFormCreate;
begin

end;

procedure TBeelineLoadCloseForm.DoAfterLoad;
var
  p: TOraStoredProc;
begin
   if countclosecontract>0 then begin
     bitbtn2.Caption:='Закрыть '+inttostr(countclosecontract)+' контрактов';
     CONTRACT_CANCEL_DATE.Date := Date();
     bitbtn2.Visible:=true;
     GroupBox1.Visible:=true;
//     Label1.Visible:=true;
   end;

end;

procedure TBeelineLoadCloseForm.DoBeforeLoad;

begin


    countclosecontract:=0;

end;

procedure TBeelineLoadCloseForm.DoLoad(var Line: String);
var qAddAbonent,qTariffs:TORaQuery;
vStringList : TStringList;
  p: TOraStoredProc;
  summ : real;
begin

if length(Line)=10 then begin
  qTariffs:=ToRaQuery.Create(Self);
  qTariffs.SQL.Text :='select vc.CONTRACT_ID,vc.CONTRACT_DATE,vc.CONTRACT_CHANGE_DATE,vc.CONTRACT_CANCEL_DATE,'+#13#10+
' nvl(dla.system_block,0) as system_block,nvl(dla.conservation,0) as conservation,nvl(dla.phone_is_active,0) as phone_is_active'+#13#10+
' from v_contracts vc, db_loader_account_phones dla'+#13#10+
' where dla.phone_number=vc.PHONE_NUMBER_FEDERAL'+#13#10+
' and dla.year_month=(select max(dla1.year_month) from db_loader_account_phones dla1'+#13#10+
' where dla1.phone_number=vc.PHONE_NUMBER_FEDERAL)'+#13#10+
' and vc.CONTRACT_DATE=(select max(vc1.CONTRACT_DATE) from v_contracts vc1'+#13#10+
' where vc1.PHONE_NUMBER_FEDERAL=vc.PHONE_NUMBER_FEDERAL)'+#13#10+
' and vc.PHONE_NUMBER_FEDERAL=:phone_num';
  qTariffs.ParamByName('PHONE_NUM').AsString:= Line;
  qTariffs.ExecSQL;
  if qTariffs.FieldByName('CONTRACT_DATE').IsNull then
    Line:=Line+#9+'Ошибка! Номер не найден!'
  else if qTariffs.FieldByName('PHONE_IS_ACTIVE').AsInteger=1 then
    Line:=Line+#9+'Номер активен.'
      else if qTariffs.FieldByName('SYSTEM_BLOCK').AsInteger=1 then
      begin
        Line:=Line+#9+'Номер блокирован за мошеничество.'+#9+qTariffs.FieldByName('CONTRACT_DATE').AsString
        +#9+qTariffs.FieldByName('CONTRACT_CHANGE_DATE').AsString
        +#9+qTariffs.FieldByName('CONTRACT_ID').AsString;
        inc(countclosecontract);
      end
      else if not qTariffs.FieldByName('CONTRACT_CANCEL_DATE').IsNull then
        Line:=Line+#9+'Контракт уже расторгнут'
      else if qTariffs.FieldByName('CONSERVATION').AsInteger=1 then  begin
        Line:=Line+#9+'Номер на сохранении.'+#9+qTariffs.FieldByName('CONTRACT_DATE').AsString
        +#9+qTariffs.FieldByName('CONTRACT_CHANGE_DATE').AsString
        +#9+qTariffs.FieldByName('CONTRACT_ID').AsString;
        inc(countclosecontract);
      end;
  FreeAndNil(qTariffs);
end
else Line:='';
end;

function TBeelineLoadCloseForm.GetFormCaption: String;
begin
  Result := 'Расторжение контрактов';
end;

function TBeelineLoadCloseForm.GetHeaderLine: String;
begin
  Result := 'Лист1';
end;

function TBeelineLoadCloseForm.IsSelectPeriodEnabled: Boolean;
begin
  Result := False;
end;

function TBeelineLoadCloseForm.IsSelectAccountEnabled: Boolean;
begin
  Result := False;
end;

procedure TBeelineLoadForm.BitBtn2Click(Sender: TObject);
  var vIsError : boolean;
   vStringList:tstringlist;
   i:integer;
   s,pErrorMessage:string;
begin
Screen.Cursor := crSQLWait;
  try
    MainForm.OraSession.StartTransaction;
    pProgress.Max := mData.Lines.Count-1;
    vStringList := TStringList.Create;
    LockWindowUpdate(mData.Handle);
    for i := 0 to mData.Lines.Count-1 do
    begin
      pProgress.Position := i;
      pProgress.Update;
      Application.ProcessMessages;
      s:=mData.Lines[i];
      if (s<>'') then  begin
       if ((GetToken(s, 2)='Номер на сохранении.') or (GetToken(s, 2)='Номер блокирован за мошеничество.')) then  begin
        qContractCancel.Close;
        qContractCancel.ParamByName('CONTRACT_CANCEL_ID').Value := Null;
        qContractCancel.Open;
        qContractCancel.Insert;
        qContractCancel.FieldByName('CONTRACT_ID').Value := GetToken(s, 5);
        vIsError:=false;
        if (Trunc(CONTRACT_CANCEL_DATE.Date) = 0) then
          begin
          vIsError := True;
          pErrorMessage := 'Дата расторжения договора должна быть заполнена';
          end
        else if strtodate(GetToken(s, 3))> Trunc(CONTRACT_CANCEL_DATE.Date) then
              begin
                vIsError := True;
                pErrorMessage := 'Дата расторжения договора должна быть больше даты заключения договора '+
                GetToken(s, 3);
              end
            else if (GetToken(s, 4)<>'') and (strtodate(GetToken(s, 4)) > Trunc(CONTRACT_CANCEL_DATE.Date)) then
              begin
                vIsError := True;
                pErrorMessage := 'Дата расторжения договора не должна быть меньше даты последнего изменения договора '+
                GetToken(s, 4);
              end;
        if (not vIsError) then begin
          try
            qGetNewId.ExecSQL;
            qContractCancel.FieldByName('FILIAL_ID').value:= 16;
            qContractCancel.FieldByName('CONTRACT_CANCEL_ID').Value := qGetNewId.ParamByName('RESULT').Value;
            qContractCancel.FieldByName('CONTRACT_CANCEL_DATE').AsDateTime := Trunc(CONTRACT_CANCEL_DATE.Date);
            qContractCancel.FieldByName('CONTRACT_CANCEL_TYPE_ID').Value:= 23;
            qContractCancel.Post;
            s:=s+#9+'Договор расторгнут.';
          except
            on e : exception do
            s:=s+#9+'Невозможно сохранить параметры расторжения договора. '+ e.Message;
          end;
        end
        else s:=s+#9+pErrorMessage;
       end
       else s:=s+#9+'Пропущен.';
       vStringList.Add(s);
      end;
    end;
    mData.Lines:=vStringList;
    vStringList.Free;
    LockWindowUpdate(0);
    MainForm.OraSession.Commit;
    qContractCancel.Close;
    Screen.Cursor := crDefault;
    bitbtn2.Visible:=false;
    GroupBox1.Visible:=false;
//    Label1.Visible:=false;
    ShowMessage('Расторжения завершены!');
  except
    Screen.Cursor := crDefault;
    MainForm.OraSession.Rollback;
    Raise;
  end;

end;

{ TBeelineLoadDopPhoneInfo }

procedure TBeelineLoadDopPhoneInfo.DoAfterLoad;
begin

end;

procedure TBeelineLoadDopPhoneInfo.DoBeforeLoad;
  var qAddDopInfo:ToRaQuery;
begin
  qAddDopInfo:=ToRaQuery.Create(self);
  try
  //vLoadInstallment:=true;
   //qAddDopInfo.SQL.Text :='truncate table PHONES_DOP';
   qAddDopInfo.SQL.Text :='delete PHONES_DOP';

   qAddDopInfo.ExecSQL;
   FreeAndNil(qAddDopInfo);
  except
    on e : exception do
    MessageDlg('Ошибка очистки таблицы PHONES_DOP'#13#10+e.Message, mtError, [mbOK], 0);
  end;

   FreeAndNil(FLoadProc);
end;

procedure TBeelineLoadDopPhoneInfo.DoLoad(var Line: String);
  var qAddDopInfo:ToRaQuery;
begin
  qAddDopInfo:=ToRaQuery.Create(self);
  try

    qAddDopInfo.SQL.Text :='INSERT INTO PHONES_DOP (BAN, DATE_CTN, HLR, NAME_BAN, PHONE_NUMBER,PHONE_NUMBER_TYPE, REASON, SIM, STATE, TP)'+#13+#10+
                        ' VALUES ( :BAN,:DATE_CTN, :HLR,:NAME_BAN,:PHONE_NUMBER,:PHONE_NUMBER_TYPE,:REASON,:SIM,:STATE,:TP )';
    qAddDopInfo.ParamByName('PHONE_NUMBER').AsString  := GetToken(Line, 1,#59);
    qAddDopInfo.ParamByName('HLR').AsString  := GetToken(Line, 2,#59);
    qAddDopInfo.ParamByName('BAN').AsString  := GetToken(Line, 3,#59);
    qAddDopInfo.ParamByName('NAME_BAN').AsString  := GetToken(Line, 4,#59);
    qAddDopInfo.ParamByName('DATE_CTN').AsDate  :=EncodeDate(
          StrToInt(Copy(GetToken(Line, 5,#59), 7, 4)),
          StrToInt(Copy(GetToken(Line, 5,#59), 4, 2)),
          StrToInt(Copy(GetToken(Line, 5,#59), 1, 2))
          );
    qAddDopInfo.ParamByName('TP').AsString  := GetToken(Line, 6,#59);
    qAddDopInfo.ParamByName('SIM').AsString  := GetToken(Line, 7,#59);

    qAddDopInfo.ExecSQL;
    FreeAndNil(qAddDopInfo);
  except
    on e : exception do
    Line:='Ошибка '+e.Message+#9+Line;
    //      MessageDlg('Ошибка при добавлении абонента "'+copy(GetToken(Line, 4),2,10)+'".'#13#10+, mtError, [mbOK], 0);
  end;

end;

function TBeelineLoadDopPhoneInfo.GetFormCaption: String;
begin
  Result := 'Загрузка доп. информации по номерам';
end;

function TBeelineLoadDopPhoneInfo.GetHeaderLine: String;
begin
  Result := 'Избирательный номер;HLR;Код клиента (BAN);Название BAN;Дата статуса CTN;Код текущего биллинг-плана (тарифного плана);Серийный номер';
end;

function TBeelineLoadDopPhoneInfo.IsSelectAccountEnabled: Boolean;
begin
  Result := False;
end;

function TBeelineLoadDopPhoneInfo.IsSelectPeriodEnabled: Boolean;
begin
  Result := False;
end;

end.
