unit BeelineLoadFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, DBCtrls, DB, MemDS, DBAccess, Ora, ComCtrls;

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
    procedure btnLoadClick(Sender: TObject);
  private
    FHeaderLineIndex: Integer;

  protected
    FAccountID : Integer;
    FAccountLogin : String;
    FLoadingYear, FLoadingMonth : Integer;

    function MakeStoredProcedure(const AText : String) : TOraStoredProc;
    function GetFloatData(const Value: string): Double;

    function GetHeaderLine : String; virtual; abstract;
    function GetFormCaption : String; virtual; abstract;
    function IsSelectPeriodEnabled : Boolean; virtual;
    function IsSelectAccountEnabled : Boolean; virtual;
    //
    procedure DoBeforeLoad; virtual; abstract;
    procedure DoLoad(const Line : String); virtual; abstract;
    procedure DoAfterLoad; virtual; abstract;
  public
    procedure Execute;
  end;

  TBeelineLoadPaymentsForm = class(TBeelineLoadForm)
  private
    FLoadProc : TOraStoredProc;
  protected
    function GetHeaderLine : String; override;
    function GetFormCaption : String; override;
    //
    procedure DoBeforeLoad; override;
    procedure DoLoad(const Line : String); override;
    procedure DoAfterLoad; override;
  end;

  TBeelineLoadStatusesForm = class(TBeelineLoadForm)
  private
    FLoadProc : TOraStoredProc;
  protected
    function GetHeaderLine : String; override;
    function GetFormCaption : String; override;
    //
    procedure DoBeforeLoad; override;
    procedure DoLoad(const Line : String); override;
    procedure DoAfterLoad; override;
  end;

  TBeelineLoadCostsForm = class(TBeelineLoadForm)
  private
    FLoadProc : TOraStoredProc;
  protected
    function GetHeaderLine : String; override;
    function GetFormCaption : String; override;
    function IsSelectPeriodEnabled : Boolean; override;
    //
    procedure DoBeforeLoad; override;
    procedure DoLoad(const Line : String); override;
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
    procedure DoLoad(const Line : String); override;
    procedure DoAfterLoad; override;

    function GetZoneName : String; virtual; abstract;
  end;

  TBeelineLoadBS_Msk_Form = class(TBeelineLoadBSForm)
  protected
    function GetFormCaption : String; override;
    function GetHeaderLine : String; override;
    function GetZoneName : String; override;
  end;

  TBeelineLoadBS_MO_Form = class(TBeelineLoadBSForm)
  protected
    function GetFormCaption : String; override;
    function GetHeaderLine : String; override;
    function GetZoneName : String; override;
  end;

implementation

uses ComObj, Main, CRStrUtils;

{$R *.dfm}

{ TBeelineLoadForm }

procedure TBeelineLoadForm.btnLoadClick(Sender: TObject);
var
  i: Integer;
  PeriodStamp: Integer;
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
    pProgress.Max := mData.Lines.Count;
    for i := FHeaderLineIndex+1 to mData.Lines.Count-1 do
    begin
      pProgress.Position := i;
      Update;
      DoLoad(mData.Lines[i]);
    end;
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
      ParsedArray := Parser.ProcessData(VarBytes);
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

{ TBeelineLoadPaymentsForm }

procedure TBeelineLoadPaymentsForm.DoAfterLoad;
var
  p: TOraStoredProc;
begin
  p := MakeStoredProcedure('DB_LOADER_PCKG.COMMIT_LOAD_PAYMENTS');
  try
    p.ParamByName('pYEAR').AsInteger := FLoadingYear;
    p.ParamByName('pMONTH').AsInteger := FLoadingMonth;
    p.ParamByName('pLOGIN').AsString := FAccountLogin;
    p.ExecSQL;
  finally
    FreeAndNil(p);
  end;
  FreeAndNil(FLoadProc);
end;

procedure TBeelineLoadPaymentsForm.DoBeforeLoad;
var
  p: TOraStoredProc;
begin
  p := MakeStoredProcedure('DB_LOADER_PCKG.START_LOAD_PAYMENTS');
  try
    p.ParamByName('pYEAR').AsInteger := FLoadingYear;
    p.ParamByName('pMONTH').AsInteger := FLoadingMonth;
    p.ParamByName('pLOGIN').AsString := FAccountLogin;
    p.ExecSQL;
  finally
    FreeAndNil(p);
  end;
end;

procedure TBeelineLoadPaymentsForm.DoLoad(const Line: String);
var
  PaymentDateStr : String;
  PaymentStatus: string;
  PaymentSum: Double;
  PaymentNumber: string;
  PhoneNumber: string;
begin
  PhoneNumber := GetToken(Line, 9);
  if PhoneNumber <> '' then
  begin
    PaymentDateStr := GetToken(Line, 1);
    if (PaymentDateStr <> '') then
      if CharInSet(PaymentDateStr[1], ['0'..'9']) then
      begin
        if FLoadProc = nil then
        begin
          FLoadProc := MakeStoredProcedure('DB_LOADER_PCKG.ADD_PAYMENT');
          FLoadProc.ParamByName('pYEAR').AsInteger := FLoadingYear;
          FLoadProc.ParamByName('pMONTH').AsInteger := FLoadingMonth;
          FLoadProc.ParamByName('pLOGIN').AsString := FAccountLogin;
        end;
        //
        FLoadProc.ParamByName('pPHONE_NUMBER').AsString := PhoneNumber;
        //
        FLoadProc.ParamByName('pPAYMENT_DATE').AsDateTime := EncodeDate(
          StrToInt(Copy(PaymentDateStr, 7, 4)),
          StrToInt(Copy(PaymentDateStr, 4, 2)),
          StrToInt(Copy(PaymentDateStr, 1, 2))
          );
        //
        PaymentStatus := GetToken(Line, 2);
        PaymentSum := GetFloatData(GetToken(Line, 3));
        if (PaymentStatus = 'Платеж зачислен')
            or (PaymentStatus = 'Перенос платежа с другого клиента')
            or (PaymentStatus = 'Отмена возврата платежа')
        then
          PaymentStatus := '' // по умолчанию - всё в порядке
        else if (PaymentStatus = 'Отмена платежа')
                or (PaymentStatus = 'Перенос платежа на другого клиента')
                or (PaymentStatus = 'Возврат платежа') then
          PaymentSum := -PaymentSum;// Сумму платёжа надо сделать отрицательной!
        FLoadProc.ParamByName('pPAYMENT_SUM').AsFloat := PaymentSum;
        //
        PaymentNumber := GetToken(Line, 8);
        if Copy(PaymentNumber, Length(PaymentNumber)-2, 3) = ',00' then
            SetLength(PaymentNumber, Length(PaymentNumber)-3);
        FLoadProc.ParamByName('pPAYMENT_NUMBER').AsString := PaymentNumber;
        if PaymentStatus = '' then
        begin
          FLoadProc.ParamByName('pPAYMENT_VALID_FLAG').AsInteger := 1;
          FLoadProc.ParamByName('pPAYMENT_STATUS_TEXT').Clear;
        end
        else
        begin
          FLoadProc.ParamByName('pPAYMENT_VALID_FLAG').AsInteger := 0;
          FLoadProc.ParamByName('pPAYMENT_STATUS_TEXT').AsString := Copy(PaymentStatus, 1, 100);
        end;
        FLoadProc.ExecSQL;
      end;
  end;
end;

function TBeelineLoadPaymentsForm.GetFormCaption: String;
begin
  Result := 'Загрузка платежей';
end;

function TBeelineLoadPaymentsForm.GetHeaderLine: String;
begin
  Result := 'Дата платежа	Статус платежа	Сумма в валюте платежa	Зачислено в валюте платежа	Тип платежа	Сумма в валюте договора	Зачислено в валюте договора	Номер платежного поручения 	Номер телефона';
end;

{ TBeelineLoadStatusesForm }

procedure TBeelineLoadStatusesForm.DoAfterLoad;
var
  p: TOraStoredProc;
begin
  p := MakeStoredProcedure('DB_LOADER_PCKG.COMMIT_LOAD_ACCOUNT_PHONES');
  try
    p.ParamByName('pYEAR').AsInteger := FLoadingYear;
    p.ParamByName('pMONTH').AsInteger := FLoadingMonth;
    p.ParamByName('pLOGIN').AsString := FAccountLogin;
    p.ExecSQL;
  finally
    FreeAndNil(p);
  end;
  FreeAndNil(FLoadProc);
end;

procedure TBeelineLoadStatusesForm.DoBeforeLoad;
var
  p: TOraStoredProc;
begin
  p := MakeStoredProcedure('DB_LOADER_PCKG.START_LOAD_ACCOUNT_PHONES');
  try
    p.ParamByName('pYEAR').AsInteger := FLoadingYear;
    p.ParamByName('pMONTH').AsInteger := FLoadingMonth;
    p.ParamByName('pLOGIN').AsString := FAccountLogin;
    p.ExecSQL;
  finally
    FreeAndNil(p);
  end;
end;

procedure TBeelineLoadStatusesForm.DoLoad(const Line: String);
var
  PhoneNumber: string;
  StatusFlag: Integer;
  CellPlanDateStr: string;
begin
  PhoneNumber := Trim(GetToken(Line, 1));
  if (PhoneNumber <> '') and CharInSet(PhoneNumber[1], ['0'..'9']) then
  begin
    if FLoadProc = nil then
    begin
      FLoadProc := MakeStoredProcedure('DB_LOADER_PCKG.ADD_ACCOUNT_PHONE');
      FLoadProc.ParamByName('pYEAR').AsInteger := FLoadingYear;
      FLoadProc.ParamByName('pMONTH').AsInteger := FLoadingMonth;
      FLoadProc.ParamByName('pLOGIN').AsString := FAccountLogin;
    end;
    FLoadProc.ParamByName('pPHONE_NUMBER').AsString := PhoneNumber;
    //
    if AnsiLowerCase(Copy(GetToken(Line, 6), 1, 4)) = 'блок' then
      StatusFlag := 0
    else
      StatusFlag := 1;
    FLoadProc.ParamByName('pPHONE_IS_ACTIVE').AsInteger := StatusFlag;
    //
    FLoadProc.ParamByName('pCELL_PLAN_CODE').AsString := Trim(GetToken(Line, 3));
    FLoadProc.ParamByName('pNEW_CELL_PLAN_CODE').AsString := Trim(GetToken(Line, 4));
    //
    CellPlanDateStr := Trim(GetToken(Line, 5));
    if Length(CellPlanDateStr) = 10 then
      FLoadProc.ParamByName('pNEW_CELL_PLAN_DATE').AsDateTime := EncodeDate(
        StrToInt(Copy(CellPlanDateStr, 7, 4)),
        StrToInt(Copy(CellPlanDateStr, 4, 2)),
        StrToInt(Copy(CellPlanDateStr, 1, 2))
        )
    else
      FLoadProc.ParamByName('pNEW_CELL_PLAN_DATE').Clear;
    //
    FLoadProc.ParamByName('pORGANIZATION_ID').Clear;
    FLoadProc.ParamByName('pNEED_RESET_OPTIONS').Clear;
    FLoadProc.ExecSQL;
  end;
end;

function TBeelineLoadStatusesForm.GetFormCaption: String;
begin
  Result := 'Загрузка статусов';
end;

function TBeelineLoadStatusesForm.GetHeaderLine: String;
begin
  Result := 'Номер телефона	Дата активации	Текущий тарифный план	Будущий тарифный план	Дата смены тарифного плана	Статус	Дата смены статуса	Причина последнего изменения	Информация';
end;

{ TBeelineLoadCostsForm }

procedure TBeelineLoadCostsForm.DoAfterLoad;
begin
  FreeAndNil(FLoadProc);
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

function TBeelineLoadForm.IsSelectAccountEnabled: Boolean;
begin
  Result := True;
end;

procedure TBeelineLoadCostsForm.DoBeforeLoad;
begin
  // Nothing
end;

procedure TBeelineLoadCostsForm.DoLoad(const Line: String);
const
  VAT = 1.18;
var
  PhoneNumber : String;
begin
  PhoneNumber := Trim(GetToken(Line, 3, ';'));
  if (PhoneNumber <> '') and CharInSet(PhoneNumber[1], ['0'..'9']) then
  begin
    if FLoadProc = nil then
    begin
      FLoadProc := MakeStoredProcedure('DB_LOADER_PCKG.SET_REPORT_DATA');
      FLoadProc.ParamByName('pDATE_LAST_UPDATE').AsDateTime := Now;
    end;
    FLoadProc.ParamByName('pPHONE_NUMBER').AsString := PhoneNumber;
    FLoadProc.ParamByName('pCURRENT_SUM').AsFloat := VAT * GetFloatData(GetToken(Line, 4, ';'));
    FLoadProc.ExecSQL;
  end;
end;

function TBeelineLoadCostsForm.GetFormCaption: String;
begin
  Result := 'Загрузка начислений';
end;

function TBeelineLoadCostsForm.GetHeaderLine: String;
begin
  Result := 'Договор;Группа счетов;Номер телефона;Предварительная стоимость (без НДС)';
end;

function TBeelineLoadCostsForm.IsSelectPeriodEnabled: Boolean;
begin
  Result := False;
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

procedure TBeelineLoadBSForm.DoLoad(const Line: String);
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

{ TBeelineLoadBS_Msk_Form }

function TBeelineLoadBS_Msk_Form.GetFormCaption: String;
begin
  Result := 'Коды базовых станций Москвы';
end;

function TBeelineLoadBS_Msk_Form.GetHeaderLine: String;
begin
  Result := '  Код тарифной зоны:  MOSCOW'#9#9#9#9#9#9#9;
end;

function TBeelineLoadBS_Msk_Form.GetZoneName: String;
begin
  Result := 'Москва';
end;

{ TBeelineLoadBS_MO_Form }

function TBeelineLoadBS_MO_Form.GetFormCaption: String;
begin
  Result := 'Коды базовых станций Московской области';
end;

function TBeelineLoadBS_MO_Form.GetHeaderLine: String;
begin
  Result := '  Код тарифной зоны:  PODM'#9#9#9#9#9#9#9;
end;

function TBeelineLoadBS_MO_Form.GetZoneName: String;
begin
  Result := 'Московская область';
end;

end.
