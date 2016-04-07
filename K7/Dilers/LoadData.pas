unit LoadData;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, MemDS, VirtualTable, Grids, DBGrids, CRGrid, ComObj, ActiveX,
  StdCtrls, ExtCtrls, DBAccess, Ora, ComCtrls, ActnList, Buttons, Main;

type
  TLoadColumn = record
    FieldName : String;
    ColumnName : String;
  end;

  TLoadDataFrm = class(TForm)
    grData: TCRDBGrid;
    dsData: TDataSource;
    qData: TVirtualTable;
    Panel1: TPanel;
    eFileName: TEdit;
    Button1: TButton;
    Label1: TLabel;
    Splitter1: TSplitter;
    qDetails: TVirtualTable;
    dsDetails: TDataSource;
    qDetailsNAME: TStringField;
    qDetailsVALUE: TStringField;
    qDataCONTRACT_NUM: TStringField;
    qDataDOCUM_TYPE_NAME: TStringField;
    qDataDOCUM_DATE: TStringField;
    qDataSURNAME: TStringField;
    qDataNAME: TStringField;
    qDataPATRONYMIC: TStringField;
    qDataBDATE: TStringField;
    qDataFILIAL_NAME: TStringField;
    qDataOPERATOR_NAME: TStringField;
    qDataIS_VIP_NAME: TStringField;
    qDataTARIFF_NAME: TStringField;
    qDataPHONE_NUMBER_FEDERAL: TStringField;
    qDataPHONE_NUMBER_CITY: TStringField;
    qDataSUM_GET: TStringField;
    qDataUSER_NAME: TStringField;
    qDataPHONE_NUMBER_TYPE: TStringField;
    qDataSIM_NUMBER: TStringField;
    qDataDISCONNECT_LIMIT: TStringField;
    qDataTARIFF_CODE: TStringField;
    qDataIS_ACTIVE: TStringField;
    qDataCONNECT_PRICE: TStringField;
    qDataADVANCE_PAYMENT: TStringField;
    qDataDAYLY_PAYMENT: TStringField;
    qDataDAYLY_PAYMENT_LOCKED: TStringField;
    qDataPASSPORT_SER: TStringField;
    qDataPASSPORT_NUM: TStringField;
    qDataPASSPORT_DATE: TStringField;
    qDataPASSPORT_GET: TStringField;
    qDataCOUNTRY_CITIZEN: TStringField;
    qDataCOUNTRY_NAME: TStringField;
    qDataREGION_NAME: TStringField;
    qDataCITY_NAME: TStringField;
    qDataSTREET_NAME: TStringField;
    qDataHOUSE: TStringField;
    qDataKORPUS: TStringField;
    qDataAPARTMENT: TStringField;
    qDataCONTACT_INFO: TStringField;
    qDataCODE_WORD: TStringField;
    qDataEMAIL: TStringField;
    qDataSTART_BALANCE: TStringField;
    qDataGOLD_NUMBER_SUM: TStringField;
    qDataCONTRACT_CANCEL_TYPE_NAME: TStringField;
    qDetailsNUM: TIntegerField;
    qDetailsIS_ERROR: TStringField;
    qDataERROR_TEXT: TStringField;
    qDataDOCUM_TYPE_ID: TIntegerField;
    qDataABONENT_ID: TIntegerField;
    qDataFILIAL_ID: TIntegerField;
    qDataOPERATOR_ID: TIntegerField;
    qDataTARIFF_ID: TIntegerField;
    qDataCITIZENSHIP: TIntegerField;
    qDataCOUNTRY_ID: TIntegerField;
    qDataREGION_ID: TIntegerField;
    qDataCONTRACT_CANCEL_TYPE_ID: TIntegerField;
    qDataSUM_GET_2: TFloatField;
    qDataSTART_BALANCE_2: TFloatField;
    qDataGOLD_NUMBER_SUM_2: TFloatField;
    qDataCONNECT_PRICE_2: TFloatField;
    qDataADVANCE_PAYMENT_2: TFloatField;
    qDataDISCONNECT_LIMIT_2: TFloatField;
    qDataDAYLY_PAYMENT_2: TFloatField;
    qDataDAYLY_PAYMENT_LOCKED_2: TFloatField;
    qDataPHONE_NUMBER_TYPE_2: TIntegerField;
    qDataIS_ACTIVE_2: TIntegerField;
    qDataCONTRACT_NUM_2: TIntegerField;
    qDataDOCUM_DATE_2: TDateField;
    qDataBDATE_2: TDateField;
    qDataPASSPORT_DATE_2: TDateField;
    qTemp: TOraQuery;
    qFindAbonentId: TOraQuery;
    pcDetails: TPageControl;
    tsErrors: TTabSheet;
    pErrors: TPanel;
    mError: TMemo;
    tsDetails: TTabSheet;
    Panel2: TPanel;
    grDetails: TCRDBGrid;
    ActionList: TActionList;
    OpenDialog1: TOpenDialog;
    aOpenFile: TAction;
    Panel3: TPanel;
    SpeedButton1: TSpeedButton;
    aLoadFile: TAction;
    qAddAbonent: TOraQuery;
    qGetNewAbonentId: TOraStoredProc;
    qGetNewContractId: TOraStoredProc;
    qAddContract: TOraQuery;
    qAddPayment: TOraQuery;
    qNewPaymentId: TOraStoredProc;
    qNewCantractCancelId: TOraStoredProc;
    qAddContractCancel: TOraQuery;
    qNewCantractChangeId: TOraStoredProc;
    qAddContractChange: TOraQuery;
    qFindPayment: TOraQuery;
    qFindContracCancel: TOraQuery;
    qFindContractChange: TOraQuery;
    qUpdatePayment: TOraQuery;
    qUpdateContractCancel: TOraQuery;
    qUpdateContractChange: TOraQuery;
    qUpdateContract: TOraQuery;
    procedure dsDataDataChange(Sender: TObject; Field: TField);
    procedure grDetailsDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure grDataDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure aOpenFileExecute(Sender: TObject);
    procedure aLoadFileExecute(Sender: TObject);
  private
    procedure FillColumnNames(const pStr: String);
    procedure DoLoadDataFromText(const pStr: String);
    function AddRowFromStr(const pStr: String) : boolean;
    function CurrentRowEmpty: boolean;
    function CheckNecessaryFields(var pErrorMessage: String): boolean;
    procedure FillDetails;
    function CheckCurrentDocum(var pErrorCount: Integer; var pErrorStr: String): boolean;
    function FindAbonentId(const pSurname, pName, pPatronymic,
      pBdate: OleVariant; const pErrorMessage: String = ''): Variant;
    function FindId(const pName, pTableName : String; //const pAddIfNotFound : boolean;
                const pNameField : String = '';
                const pIDField : String = '';
                const pErrorMessage : String = '') : Variant;
    procedure FillAdditionalFields;
    function GetDate(const pStr: String): Variant;
    function GetFloat(const pStr: String): Variant;
    function GetInteger(const pStr: String): Variant;
    procedure DoShowErrors;
    function AddAbonent : Variant;
    function SaveContract(const pAbonentId : Variant) : Variant;
    function SavePayment: Variant;
    function SaveContractCancel: Variant;
    function SaveContractChange(const pTypeDoc : Integer): Variant;
    function FindPaymentId(const pContractId,
      pDocumDate: Variant): Variant;
    function FindContractCancelId(const pContractId,
      pDocumDate: Variant): Variant;
    function FindContractChangeId(const pContractId, pDocumDate,
      pDocumType: Variant): Variant;
    function DoOpenFile(const pFileName: String): boolean;
    function NormalizePhoneNumber(const pPhoneNumber: String): String;
  public
    FReadData : boolean;

    function DoLoadDataFromExcel(const pFileName : String) : boolean;
  end;

  procedure LoadDataFromExcelFile;

implementation

{$R *.dfm}

uses ContractsRegistration_Utils;

const
  vColumnCount = 43;

  aColumnNames : array[1..vColumnCount] of String = (
 '№ контракта',
 'Тип документа',
 'Дата документа',
 'Фамилия',
 'Имя',
 'Отчество',
 'Д.Р.',
 'Филиал',
 'Оператор',
 'VIP',
 'Тариф',
 '№ телефона федеральн',
 '№ телефона городской',
 'Внесенная сумма',
 'Зарегистрировал',
 'Тип номера',
 'SIM карта',
 'Лимит отключения',
 'Тип тел номера',
 'Код тарифа',
 'Тариф действующий',
 'Стоимость подключения',
 'Авансовый платеж',
 'Абонентская плата',
 'Абонентская плата по тарифу (заблок)',
 'Серия паспорта',
 'Номер паспорта',
 'Когда выдан паспорт',
 'Кем выдан паспорт',
 'Гражданство',
 'Страна прописки',
 'Регион прописки',
 'Город прописки',
 'Улика прописки',
 'Дом прописки',
 'Корпус',
 'Квартира',
 'Контактная информация',
 'Кодовое слово',
 'E-mail',
 'стартовый баланс',
 'Стоим золотого номера',
 'Причина расторжения договора');

 // имена полей должны точно совпадать с массивом aColumnNames
  aFieldNames : array[1..vColumnCount] of String = (
 'CONTRACT_NUM',
 'DOCUM_TYPE_NAME',
 'DOCUM_DATE',
 'SURNAME',
 'NAME',
 'PATRONYMIC',
 'BDATE',
 'FILIAL_NAME',
 'OPERATOR_NAME',
 'IS_VIP_NAME',
 'TARIFF_NAME',
 'PHONE_NUMBER_FEDERAL',
 'PHONE_NUMBER_CITY',
 'SUM_GET',
 'USER_NAME',
 'PHONE_NUMBER_TYPE',
 'SIM_NUMBER',
 'DISCONNECT_LIMIT',
 'PHONE_NUMBER_TYPE',
 'TARIFF_CODE',
 'IS_ACTIVE',
 'CONNECT_PRICE',
 'ADVANCE_PAYMENT',
 'DAYLY_PAYMENT',
 'DAYLY_PAYMENT_LOCKED',
 'PASSPORT_SER',
 'PASSPORT_NUM',
 'PASSPORT_DATE',
 'PASSPORT_GET',
 'COUNTRY_CITIZEN',
 'COUNTRY_NAME',
 'REGION_NAME',
 'CITY_NAME',
 'STREET_NAME',
 'HOUSE',
 'KORPUS',
 'APARTMENT',
 'CONTACT_INFO',
 'CODE_WORD',
 'EMAIL',
 'START_BALANCE',
 'GOLD_NUMBER_SUM',
 'CONTRACT_CANCEL_TYPE_NAME');

  // поля, которые обязательно должны быть в загружаемом файле
  aNecessaryFieldsCount = 13;
  aNecessaryFields : array[1..aNecessaryFieldsCount] of String = (
 'CONTRACT_NUM',
 'DOCUM_TYPE_NAME',
 'DOCUM_DATE',
 'SURNAME',
 'NAME',
 'PATRONYMIC',
 'BDATE',
 'FILIAL_NAME',
 'OPERATOR_NAME',
 'TARIFF_NAME',
 'PHONE_NUMBER_FEDERAL',
 'SUM_GET',
 'SIM_NUMBER');

var
  aColumnNumbers : array[1..vColumnCount] of Integer;

procedure LoadDataFromExcelFile;
var
  LoadDataFrm: TLoadDataFrm;
begin
  try
    LoadDataFrm := TLoadDataFrm.Create(nil);
    try
      if LoadDataFrm.OpenDialog1.Execute then
      begin
        //LoadDataFrm.eFileName.Text := LoadDataFrm.OpenDialog1.FileName;
        LoadDataFrm.Caption := 'Предварительный просмотр загружаемых данных "' + LoadDataFrm.eFileName.Text + '".';
         //LoadDataFrm.aOpenFile.Execute;
        if LoadDataFrm.DoOpenFile(LoadDataFrm.OpenDialog1.FileName) then
        begin
          LoadDataFrm.ShowModal;
         end;
      end;
    finally
      LoadDataFrm.Free;
    end;
  except
    on e : exception do
      MessageDlg('Ошибка при загрузке файла.', mtError, [mbOK], 0);
  end;
end;

{ TLoadDataFrm }

// заполнить массив номеров колонок aColumnNumbers
procedure TLoadDataFrm.FillColumnNames(const pStr : String);
var vStringList : TStringList;
    i, j : Integer;
begin
  vStringList := TStringList.Create();
  try
    vStringList.Text := StringReplace(pStr, #9, #13#10,[rfReplaceAll, rfIgnoreCase]);
    for i := 0 to vStringList.Count-1 do
    begin
      for j := 1 to vColumnCount do
      begin
        if Trim(AnsiUpperCase(vStringList.Strings[i])) = Trim(AnsiUpperCase(aColumnNames[j])) then
        begin
          aColumnNumbers[j] := i;
        end;
      end;
    end;
  finally
    vStringList.Free;
  end;
end;

// текущая строка не заполнена
function TLoadDataFrm.CurrentRowEmpty : boolean;
var vDataExists : boolean;
    i : Integer;
begin
  vDataExists := False;
  if qData.Active then
  begin
    for i := 0 to qData.FieldCount-1 do
      vDataExists := vDataExists or (VarToStr(qData.Fields[i].Value) <> '');
  end;
  Result := not vDataExists;
end;

// Заполнить допоолительные поля
procedure TLoadDataFrm.FillAdditionalFields;
begin
  //qData.Edit;
  // из справочников
  qData.FieldByName('DOCUM_TYPE_ID').Value := FindId(qData.FieldByName('DOCUM_TYPE_NAME').AsString, 'DOCUM_TYPES');
  qData.FieldByName('FILIAL_ID').Value     := FindId(qData.FieldByName('FILIAL_NAME').AsString, 'FILIALS');
  qData.FieldByName('OPERATOR_ID').Value   := FindId(qData.FieldByName('OPERATOR_NAME').AsString, 'OPERATORS');
  qData.FieldByName('TARIFF_ID').Value     := FindId(qData.FieldByName('TARIFF_NAME').AsString, 'TARIFFS');
  qData.FieldByName('CITIZENSHIP').Value   := FindId(qData.FieldByName('COUNTRY_CITIZEN').AsString, 'COUNTRIES', 'COUNTRY_NAME', 'COUNTRY_ID');
  qData.FieldByName('COUNTRY_ID').Value    := FindId(qData.FieldByName('COUNTRY_NAME').AsString, 'COUNTRIES', 'COUNTRY_NAME', 'COUNTRY_ID');
  qData.FieldByName('REGION_ID').Value     := FindId(qData.FieldByName('REGION_NAME').AsString, 'REGIONS');
  qData.FieldByName('CONTRACT_CANCEL_TYPE_ID').Value
                                           := FindId(qData.FieldByName('CONTRACT_CANCEL_TYPE_NAME').AsString, 'CONTRACT_CANCEL_TYPES');
  qData.FieldByName('ABONENT_ID').Value    := FindAbonentId(qData.FieldByName('SURNAME').Value,
                                                            qData.FieldByName('NAME').Value,
                                                            qData.FieldByName('PATRONYMIC').Value,
                                                            qData.FieldByName('BDATE').Value);
  // число
  qData.FieldByName('SUM_GET_2').Value              := GetFloat(qData.FieldByName('SUM_GET').AsString);
  qData.FieldByName('START_BALANCE_2').Value        := GetFloat(qData.FieldByName('START_BALANCE').AsString);
  qData.FieldByName('GOLD_NUMBER_SUM_2').Value      := GetFloat(qData.FieldByName('GOLD_NUMBER_SUM').AsString);
  qData.FieldByName('CONNECT_PRICE_2').Value        := GetFloat(qData.FieldByName('CONNECT_PRICE').AsString);
  qData.FieldByName('ADVANCE_PAYMENT_2').Value      := GetFloat(qData.FieldByName('ADVANCE_PAYMENT').AsString);
  qData.FieldByName('DISCONNECT_LIMIT_2').Value     := GetFloat(qData.FieldByName('DISCONNECT_LIMIT').AsString);
  qData.FieldByName('DAYLY_PAYMENT_2').Value        := GetFloat(qData.FieldByName('DAYLY_PAYMENT').AsString);
  qData.FieldByName('DAYLY_PAYMENT_LOCKED_2').Value := GetFloat(qData.FieldByName('DAYLY_PAYMENT_LOCKED').AsString);
  // целое число
  qData.FieldByName('PHONE_NUMBER_TYPE_2').Value    := GetInteger(qData.FieldByName('PHONE_NUMBER_TYPE').AsString);
  qData.FieldByName('IS_ACTIVE_2').Value            := GetInteger(qData.FieldByName('IS_ACTIVE').AsString);
  qData.FieldByName('CONTRACT_NUM_2').Value         := GetInteger(qData.FieldByName('CONTRACT_NUM').AsString);
  // дата
  qData.FieldByName('DOCUM_DATE_2').Value           := GetDate(qData.FieldByName('DOCUM_DATE').AsString);
  qData.FieldByName('BDATE_2').Value                := GetDate(qData.FieldByName('BDATE').AsString);
  qData.FieldByName('PASSPORT_DATE_2').Value        := GetDate(qData.FieldByName('PASSPORT_DATE').AsString);
  //qData.Post;
end;

// добавить строку в Dataset из строки
function TLoadDataFrm.AddRowFromStr(const pStr : String) : boolean;
var vStringList : TStringList;
    j : Integer;
    vErrorCount : Integer;
    vErrorStr : String;
begin
  Result := False;

  if not qData.Active then
    qData.Open;
  //qData.Insert;
  qData.Append;
  try
    vStringList := TStringList.Create();
    try
      vStringList.Text := StringReplace(pStr, #9, #13#10, [rfReplaceAll, rfIgnoreCase]);
      for j := 1 to vColumnCount do
      begin
        if (aColumnNumbers[j] > 0) and (aColumnNumbers[j] < vStringList.Count) then
        begin
          qData.FieldByName(aFieldNames[j]).Value := vStringList[aColumnNumbers[j]];
        end;
      end;
    finally
      vStringList.Free;
    end;
  finally
    // пустые строки не добавляем
    if CurrentRowEmpty then
      qData.Cancel
    else
    begin
      // заполнить доподллнительные поля
      FillAdditionalFields;

      // выполнить проверки и заполнить поле
      if not CheckCurrentDocum(vErrorCount, vErrorStr) then
      begin
        qData.FieldByName('ERROR_TEXT').AsString :=
          'Ошибки ('+IntToStr(vErrorCount)+') :'#13#10+ vErrorStr;
      end;

      qData.Post;
      Result := True;
    end;
  end;
end;

// проверить, есть ли обязательные колонки в загружаемом файле
//   (номера загружаемых колонок должны быть уже заполнены в массиве aColumnNumbers)
function TLoadDataFrm.CheckNecessaryFields(var pErrorMessage : String) : boolean;
  // код обязательного поля в массиве aFieldNames
  function GetFieldIndex(const pFieldName : String) : Integer;
  var i : Integer;
  begin
    Result := 0;
    for i := 1 to vColumnCount do
    begin
      if aFieldNames[i] = pFieldName then
        Result := i;
    end;
  end;
var i, j : Integer;
begin
  pErrorMessage := '';
  for i := 1 to aNecessaryFieldsCount do
  begin
    // код обязательного поля в массиве aFieldNames и aColumnNames
    j := GetFieldIndex(aNecessaryFields[i]);
    //
    if j < 1 then
      MessageDlg('Внутренняя ошибка. Обязательное поле "'+aNecessaryFields[i]+'" не найдено в списке полей для загрузки.', mtError, [mbOK], 0)
    else if aColumnNumbers[j] < 1 then
      pErrorMessage := pErrorMessage + #13#10 + aColumnNames[j];
  end;
  Result := (pErrorMessage = '');
  if pErrorMessage <> '' then
  begin
    pErrorMessage := 'Ошибка загрузки.'#13#10'В загружаемом файле отсутствуют обязательные поля :'+ pErrorMessage+'.';
  end
end;

procedure TLoadDataFrm.DoLoadDataFromText(const pStr: String);
var vStringList : TStringList;
    vFindColumnNames : boolean;
    i : Integer;
    vCheckNecessaryFields : boolean;
    vErrorMessage : String;
    vOldCursor : TCursor;
    vTotalRows : Integer;
    vErrorRows : Integer;
begin
  vErrorRows := 0;
  vTotalRows := 0;

  vOldCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    if qData.Active then
    begin
      qData.First;
      while not qData.Eof do
        qData.Delete;
    end;

    vFindColumnNames := False;
    vStringList := TStringList.Create();
    try
      vStringList.Text := pStr;
      for i := 0 to vStringList.Count-1 do
      begin
        // пока не нашли строку с именами колонок, идем и ищем
        //    даже если уже нашли, но есть имя колонки, то перезаполняем номера колонок
        if not vFindColumnNames or (Pos(#9'Тип документа'#9, vStringList[i]) > 0) then
        begin
          // если есть такая строка, значит наверно эта строка с именами колонок
          if Pos(#9'Тип документа'#9, vStringList[i]) > 0 then
          begin
            FillColumnNames(vStringList[i]);
            vCheckNecessaryFields := CheckNecessaryFields(vErrorMessage);
            if not vCheckNecessaryFields then
            begin
              MessageDlg(vErrorMessage, mtError, [mbOK], 0);
              vFindColumnNames := False;
            end
            else
              vFindColumnNames := True;
          end;
        end
        else // если нашли строку с именами колонок
        begin
          if AddRowFromStr(vStringList[i]) then
          begin
            vTotalRows := vTotalRows + 1;
            if qData.FieldByName('ERROR_TEXT').AsString <> '' then
              vErrorRows := vErrorRows + 1;
          end;
        end;
      end;
      if qData.Active then
        qData.First;
    finally
      vStringList.Free;
    end;
  finally
    Screen.Cursor := vOldCursor;
  end;
  if vTotalRows = 0 then
    MessageDlg('В открытом файле не обнаружено ни одного документа.', mtError, [mbOK], 0)
  else
  begin
    if vErrorRows > 0 then
      MessageDlg('В открытом файле обнаружено '+IntToStr(vTotalRows)+' документов,'#13#10+' из них документов с ошибками '+IntToStr(vErrorRows)+'.', mtWarning, [mbOK], 0)
    //else
    //  MessageDlg('В открытом файле обнаружено '+IntToStr(vTotalRows)+' документов.'#13#10+' Ошибок не обнаружено.', mtInformation, [mbOK], 0)
      ;
  end;
end;

function TLoadDataFrm.DoLoadDataFromExcel(const pFileName: String) : boolean;
var StreamAdapter : TStreamAdapter;
    FileStream : TFileStream;
    ExcelParser : OleVariant;
    ParsedArray : OleVariant;
    ExcelText : WideString;
    vOldCursor : TCursor;
begin
  Result := False;
  try
    FReadData := True;
    
    vOldCursor := Screen.Cursor;
    Screen.Cursor := crHourGlass;
    try
      FileStream := TFileStream.Create(pFileName, fmOpenRead);
    finally
      Screen.Cursor := vOldCursor;
    end;

    try
      StreamAdapter := TStreamAdapter.Create(FileStream, soReference);
      try
        ExcelParser := CreateOleObject('TariferPreProcessor.PreProcessExcelFull');
        try
          ParsedArray := ExcelParser.ProcessData(StreamAdapter as IStream);
          try
            if not VarIsArray(ParsedArray) then
              MessageDlg('Некорректный формат файла  "'+pFileName+'".', mtError, [mbOK], 0)
            else if (VarArrayHighBound(ParsedArray, 1) - VarArrayLowBound(ParsedArray, 1)) < 0 then
              MessageDlg('Некорректный формат файла  "'+pFileName+'".', mtError, [mbOK], 0)
            else
            begin
              ExcelText := ParsedArray[VarArrayLowBound(ParsedArray, 1)];
              DoLoadDataFromText(ExcelText);
              //MessageDlg(ExcelText, mtError, [mbOK], 0)
              Result := True;
            end;
          finally
            //ParsedArray := Nil;
            //FreeAndNil(ParsedArray);
            ;
          end;
        finally
          //ExcelParser := Nil;
          //FreeAndNil(ExcelParser);
          ;
        end;
      finally
        //StreamAdapter := Nil;
        //FreeAndNil(StreamAdapter);
        //StreamAdapter.Free;
      end;
    finally
      FileStream.Free;
      FReadData := False;
    end;
  except
    on e : exception do
      MessageDlg('Ошибка при открытии файла "'+pFileName+'".'#13#10+e.Message, mtError, [mbOK], 0);
  end;
end;

procedure TLoadDataFrm.DoShowErrors;
begin
  mError.Lines.Clear;
  if qData.Active and (qData.RecordCount > 0) and (qData.FieldByName('ERROR_TEXT').AsString <> '') then
  begin
    mError.Lines.Text := qData.FieldByName('ERROR_TEXT').AsString;
    mError.Font.Color := clRed;
    pcDetails.ActivePage := tsErrors;
  end
  else
  begin
    if qData.Active and (qData.RecordCount > 0) then
      mError.Lines.Text := 'Ошибок в выбранном документе нет .'
    else
      mError.Lines.Text := 'Ошибок нет.';
    mError.Font.Color := clWindowText;
    pcDetails.ActivePage := tsDetails;
  end;
end;

procedure TLoadDataFrm.dsDataDataChange(Sender: TObject; Field: TField);
begin
  if not FReadData then
  begin
    FillDetails;
    DoShowErrors;
  end;
end;

procedure TLoadDataFrm.FillDetails;
var i : Integer;
    vRowName : String;
begin
  begin
    if not qDetails.Active then
      qDetails.Open
    else
    begin
       if qDetails.RecordCount > 0 then
         vRowName := qDetails.FieldByName('NAME').AsString;
    end;

    qDetails.DisableControls;
    try
      qDetails.First;
      while not qDetails.Eof do
        qDetails.Delete;

      if qData.Active then
      begin
        try
          //for i := 0 to qData.FieldCount-1 do
          for i := 0 to grData.Columns.Count-1 do
          begin
            //if qData.Fields[i].AsString <> '' then
            begin
              qDetails.Insert;
              qDetails.FieldByName('NUM').AsInteger := i+1;
              qDetails.FieldByName('NAME').Value := grData.Columns[i].Field.DisplayLabel;
              qDetails.FieldByName('VALUE').Value := grData.Columns[i].Field.AsString;
              qDetails.Post;
            end;
          end;
          if vRowName <> '' then
            qDetails.Locate('NAME', vRowName, [])
          else
            qDetails.First
        except
          on e : exception do
            MessageDlg('Ошибка.'#13#10+e.Message, mtError, [mbOK], 0);
        end;
      end;
    finally
      qDetails.EnableControls;
    end;
  end;
end;

function TLoadDataFrm.FindAbonentId(const pSurname, pName, pPatronymic, pBdate : OleVariant;
                const pErrorMessage : String = '') : Variant;
var vRes : Variant;
begin
  vRes := Null;
  if (VarToStr(pSurname) = '') and (VarToStr(pName) = '') and (VarToStr(pPatronymic) = '') and (VarToStr(pBdate) = '') then
  begin
    qFindAbonentId.Close;
    qFindAbonentId.ParamByName('SURNAME').Value := pSurname;
    qFindAbonentId.ParamByName('NAME').Value := pName;
    qFindAbonentId.ParamByName('PATRONYMIC').Value := pPatronymic;
    qFindAbonentId.ParamByName('BDATE').Value := pBdate;
    try
      qFindAbonentId.Open;
      if qFindAbonentId.RecordCount > 0 then
        vRes := qFindAbonentId.FieldByName('ABONENT_ID').Value;
    except
      on e : exception do
        if pErrorMessage = '' then
          MessageDlg('Ошибка при получеинии кода абонента.'#13#10+e.Message, mtError, [mbOK], 0)
        else
          MessageDlg(pErrorMessage+#13#10+e.Message, mtError, [mbOK], 0)
    end;
  end;
  Result := vRes;
end;

function TLoadDataFrm.FindId(const pName, pTableName : String; //const pAddIfNotFound : boolean;
                const pNameField : String = '';
                const pIDField : String = '';
                const pErrorMessage : String = '') : Variant;
var vNameField : String;
    vIdField : String;
    vRes : Variant;
begin
  vRes := Null;
  if Trim(pName) <> '' then
  begin
    if pNameField = '' then
      vNameField := Copy(pTableName, 1, Length(pTableName)-1) + '_NAME'
    else
      vNameField := pNameField;
    if pIDField = '' then
      vIDField := Copy(pTableName, 1, Length(pTableName)-1) + '_ID'
    else
      vIDField := pIDField;
    qTemp.Close;
    qTemp.SQL.Text := 'SELECT '+vIDField+' FROM '+pTableName+' WHERE TRIM(UPPER('+vNameField+')) = TRIM(UPPER('''+pName+'''))';
    try
      qTemp.Open;
      if qTemp.RecordCount > 0 then
        vRes := qTemp.FieldByName(vIDField).AsInteger
      {
      else if pAddIfNotFound then
      begin
        qTemp.SQL.Text := 'INSERT INTO '+pTableName+'('+vIDField+','+vNameField+') VALUES '
        'SELECT '+vIDField+' FROM '+pTableName+' WHERE TRIM(UPPER('+vNameField+')) = TRIM(UPPER('''+pName+'''))';
      end
      }
      ;
    except
      on e : exception do
        if pErrorMessage = '' then
          MessageDlg('Ошибка при получеинии кода.'#13#10+e.Message, mtError, [mbOK], 0)
        else
          MessageDlg(pErrorMessage+#13#10+e.Message, mtError, [mbOK], 0)
    end;
  end;
  Result := vRes;
end;

function TLoadDataFrm.FindPaymentId(const pContractId, pDocumDate : Variant) : Variant;
var vRes : Variant;
begin
  vRes := Null;
  qFindPayment.Close;
  qFindPayment.ParamByName('CONTRACT_ID').Value := pContractId;
  qFindPayment.ParamByName('DOCUM_DATE').Value := pDocumDate;
  qFindPayment.Open;
  if qFindPayment.RecordCount > 0 then
    vRes := qFindPayment.FieldByName('ID').Value;
  Result := vRes;
end;

function TLoadDataFrm.FindContractCancelId(const pContractId, pDocumDate : Variant) : Variant;
var vRes : Variant;
begin
  vRes := Null;
  qFindContracCancel.Close;
  qFindContracCancel.ParamByName('CONTRACT_ID').Value := pContractId;
  qFindContracCancel.ParamByName('DOCUM_DATE').Value := pDocumDate;
  qFindContracCancel.Open;
  if qFindContracCancel.RecordCount > 0 then
    vRes := qFindContracCancel.FieldByName('ID').Value;
  Result := vRes;
end;

function TLoadDataFrm.FindContractChangeId(const pContractId, pDocumDate, pDocumType : Variant) : Variant;
var vRes : Variant;
begin
  vRes := Null;
  qFindContractChange.Close;
  qFindContractChange.ParamByName('CONTRACT_ID').Value := pContractId;
  qFindContractChange.ParamByName('DOCUM_DATE').Value := pDocumDate;
  qFindContractChange.ParamByName('DOCUM_TYPE_ID').Value := pDocumType;
  qFindContractChange.Open;
  if qFindContractChange.RecordCount > 0 then
    vRes := qFindContractChange.FieldByName('ID').Value;
  Result := vRes;
end;

function TLoadDataFrm.GetFloat(const pStr : String) : Variant;
begin
  if Trim(pStr) = '' then
    Result := Null
  else
  begin
    try
      Result := StrToFloat(StringReplace(pStr, '.', ',', []));
    except
      try
        Result := StrToFloat(StringReplace(pStr, ',', '.', []));
      except
        Result := Null;
      end;
    end;
  end;
end;

function TLoadDataFrm.GetInteger(const pStr : String) : Variant;
var vFloat : Variant;
begin
  if Trim(pStr) = '' then
    Result := Null
  else
  begin
    vFloat := GetFloat(pStr);
    // если не число или не целое число, то возвращаем Null
    if (VarToStr(vFloat) = '') or (Trunc(vFloat) <> vFloat) then
      Result := Null
    else
      Result := Trunc(vFloat);
  end;
end;

function TLoadDataFrm.GetDate(const pStr : String) : Variant;
var vYear, vMonths, vDay : Word;
begin
  if Trim(pStr) = '' then
    Result := Null
  else
  begin
    try
      // должен быть формат даты DD.MM.YYYY
      vDay := StrToInt(copy(pStr, 1, 2));
      vMonths := StrToInt(copy(pStr, 4, 2));
      vYear := StrToInt(copy(pStr, 7, 4));
      Result := EncodeDate(vYear, vMonths, vDay);
    except
      Result := Null;
    end;
  end;
end;

procedure TLoadDataFrm.grDetailsDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
var
  g: TCRDBGrid;
begin
  g := Sender as TCRDBGrid;
  if (Column.FieldName = 'NUM') or (Column.FieldName = 'NAME') then
  begin
    g.Canvas.Font.Color   := clBtnFace; // цвет заливки НЕ выделенной ячейки в НЕ активном гриде
  end;

  g.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

function TLoadDataFrm.CheckCurrentDocum(var pErrorCount : Integer; var pErrorStr : String) : boolean;
var
  vRes : boolean;
  vTypeDocTxt : String;
  vTypeDocId : Variant; 
  //
  procedure AddError(const pErrorText : String; const pColumnName : String = '');
  begin
    if pErrorStr <> '' then
      pErrorStr := pErrorStr + #13#10;
    if pColumnName = '' then
      pErrorStr := pErrorStr + pErrorText
    else
      pErrorStr := pErrorStr + '"' + pColumnName + '" - ' + pErrorText;
    pErrorCount := pErrorCount + 1;
  end;
  //
  procedure CheckCondition(const pCondition : boolean; const pErrorText : String);
  begin
    if pCondition then
    begin
      vRes := False;
      AddError(IntToStr(pErrorCount+1) + '. ' + pErrorText);
    end;
  end;
  //
begin
  vRes := True;
  pErrorStr := '';
  pErrorCount := 0;
  //
  vTypeDocId := qData.FieldByName('DOCUM_TYPE_ID').Value;                                                 
  vTypeDocTxt := Trim(AnsiUpperCase(qData.FieldByName('DOCUM_TYPE_NAME').AsString));
  //CheckCondition(vTypeDocTxt = '', 'Тип документа должен быть заполнен.');
  CheckCondition(not
                              (
                                (vTypeDocTxt = Trim(AnsiUpperCase(TYPE_DOC_PAYMENT_TXT))) or
                                (vTypeDocTxt = Trim(AnsiUpperCase(TYPE_DOC_CONTRACT_TXT))) or
                                (vTypeDocTxt = Trim(AnsiUpperCase(TYPE_DOC_CHANGE_SIM_TXT))) or
                                (vTypeDocTxt = Trim(AnsiUpperCase(TYPE_DOC_CHANGE_PHONE_NUM_TXT))) or
                                (vTypeDocTxt = Trim(AnsiUpperCase(TYPE_DOC_CHANGE_TARIFF_TXT))) or
                                (vTypeDocTxt = Trim(AnsiUpperCase(TYPE_DOC_CONTRACT_CANCEL_TXT)))
                              )
                              , 'В поле "Тип документа" должно быть одно из значений: '+
                                '"'+TYPE_DOC_PAYMENT_TXT+'", '+
                                '"'+TYPE_DOC_CONTRACT_TXT+'", ' +
                                '"'+TYPE_DOC_CHANGE_SIM_TXT+'", ' +
                                '"'+TYPE_DOC_CHANGE_PHONE_NUM_TXT+'", ' +
                                '"'+TYPE_DOC_CHANGE_TARIFF_TXT+'", ' +
                                '"'+TYPE_DOC_CONTRACT_CANCEL_TXT+'".'
  );
  // на всякий случай
  //CheckCondition(VarToStr(vTypeDocId) = '', 'Тип документа не найден в справочнике типов документов.');
  // если тип не заполнен или заполнен не правильно, то дальше не проверяем
  if vRes then
  begin
    // справочники
    CheckCondition(qData.FieldByName('CONTRACT_NUM').AsString = '', 'Номер контракта должен быть заполнен.');
    CheckCondition(qData.FieldByName('DOCUM_DATE').AsString = '', 'Дата документа должна быть заполнена.');
    CheckCondition(qData.FieldByName('FILIAL_NAME').AsString = '', 'Филиал должен быть заполнен.');

    case StrToInt(VarToStr(vTypeDocId)) of
      TYPE_DOC_PAYMENT :
        begin
         CheckCondition(qData.FieldByName('SUM_GET').AsString = '', 'Сумма оплаты должна быть заполнена.');
        end;
      TYPE_DOC_CONTRACT :
        begin
         CheckCondition(qData.FieldByName('SURNAME').AsString = '', 'Фамилия абонента должна быть заполнена.');
         CheckCondition(qData.FieldByName('NAME').AsString = '', 'Имя абонента должна быть заполнена.');
         CheckCondition(qData.FieldByName('PATRONYMIC').AsString = '', 'Отчество абонента должно быть заполнено.');
         CheckCondition(qData.FieldByName('BDATE').AsString = '', 'Дата рождения должна быть заполнена.');
         CheckCondition(qData.FieldByName('OPERATOR_NAME').AsString = '', 'Наименование оператора должно быть заполнено.');
         CheckCondition(qData.FieldByName('TARIFF_NAME').AsString = '', 'Наименование тарифа должно быть заполнено.');
         CheckCondition(qData.FieldByName('PHONE_NUMBER_FEDERAL').AsString = '', 'Федеральный номер должен быть заполнен.');
        end;
      TYPE_DOC_CHANGE_SIM :
        begin
         CheckCondition(qData.FieldByName('SIM_NUMBER').AsString = '', 'Номер SIM карты должен быть заполнен.');
         //CheckCondition(qData.FieldByName('SUM_GET').AsString = '', 'Сумма оплаты должна быть заполнена.');
        end;
      TYPE_DOC_CHANGE_PHONE_NUM :
        begin
         CheckCondition(qData.FieldByName('PHONE_NUMBER_FEDERAL').AsString = '', 'Федеральный номер должен быть заполнен.');
         CheckCondition(qData.FieldByName('SIM_NUMBER').AsString = '', 'Номер SIM карты должен быть заполнен.');
         //CheckCondition(qData.FieldByName('SUM_GET').AsString = '', 'Сумма оплаты должна быть заполнена.');
        end;
      TYPE_DOC_CHANGE_TARIFF :
        begin
         CheckCondition(qData.FieldByName('TARIFF_NAME').AsString = '', 'Наименование тарифа должно быть заполнено.');
         //CheckCondition(qData.FieldByName('SUM_GET').AsString = '', 'Сумма оплаты должна быть заполнена.');
        end;
      TYPE_DOC_CONTRACT_CANCEL :
        begin
          ;
        end;
    else
      ; // такого не должно быть 
    end;

    // справочники
    CheckCondition((qData.FieldByName('DOCUM_TYPE_NAME').AsString <> '') and (qData.FieldByName('DOCUM_TYPE_ID').AsString = ''),
                   'Тип документа "'+qData.FieldByName('DOCUM_TYPE_NAME').AsString+'" не найден в справочнике типов документов.');
    CheckCondition((qData.FieldByName('FILIAL_NAME').AsString <> '') and (qData.FieldByName('FILIAL_ID').AsString = ''),
                   'Филиал "'+qData.FieldByName('FILIAL_NAME').AsString+'" не найден в справочнике филиалов.');
    CheckCondition((qData.FieldByName('OPERATOR_NAME').AsString <> '') and (qData.FieldByName('OPERATOR_ID').AsString = ''),
                   'Оператор "'+qData.FieldByName('OPERATOR_NAME').AsString+'" не найден в справочнике операторов.');
    CheckCondition((qData.FieldByName('TARIFF_NAME').AsString <> '') and (qData.FieldByName('TARIFF_ID').AsString = ''),
                   'Тариф "'+qData.FieldByName('TARIFF_NAME').AsString+'" не найден в справочнике тарифов.');
    CheckCondition((qData.FieldByName('COUNTRY_CITIZEN').AsString <> '') and (qData.FieldByName('CITIZENSHIP').AsString = ''),
                   'Страна гражданства "'+qData.FieldByName('COUNTRY_CITIZEN').AsString+'" не найдена в справочнике стран.');
    CheckCondition((qData.FieldByName('COUNTRY_NAME').AsString <> '') and (qData.FieldByName('COUNTRY_ID').AsString = ''),
                   'Страна прописки "'+qData.FieldByName('COUNTRY_NAME').AsString+'" не найдена в справочнике стран.');
    CheckCondition((qData.FieldByName('REGION_NAME').AsString <> '') and (qData.FieldByName('REGION_ID').AsString = ''),
                   'Регион прописки "'+qData.FieldByName('REGION_NAME').AsString+'" не найден в справочнике регионов.');
    CheckCondition((qData.FieldByName('CONTRACT_CANCEL_TYPE_NAME').AsString <> '') and (qData.FieldByName('CONTRACT_CANCEL_TYPE_ID').AsString = ''),
                   'Причина расторжения договора "'+qData.FieldByName('CONTRACT_CANCEL_TYPE_NAME').AsString+'" не найдена в справочнике причин расторжения.');

    CheckCondition((qData.FieldByName('SUM_GET').AsString <> '') and (qData.FieldByName('SUM_GET_2').AsString = ''),
                   'Полученная сумма должна быть числом.');
    CheckCondition((qData.FieldByName('START_BALANCE').AsString <> '') and (qData.FieldByName('START_BALANCE_2').AsString = ''),
                   'Стартовый баланс должен быть числом.');
    CheckCondition((qData.FieldByName('GOLD_NUMBER_SUM').AsString <> '') and (qData.FieldByName('GOLD_NUMBER_SUM_2').AsString = ''),
                   'Стоимость "золотого" номера должна быть числом.');
    CheckCondition((qData.FieldByName('CONNECT_PRICE').AsString <> '') and (qData.FieldByName('CONNECT_PRICE_2').AsString = ''),
                   'Стоимость подключения должна быть числом.');
    CheckCondition((qData.FieldByName('ADVANCE_PAYMENT').AsString <> '') and (qData.FieldByName('ADVANCE_PAYMENT_2').AsString = ''),
                   'Авансовый платеж должен быть числом.');
    CheckCondition((qData.FieldByName('DISCONNECT_LIMIT').AsString <> '') and (qData.FieldByName('DISCONNECT_LIMIT_2').AsString = ''),
                   'Предел отключения должен быть числом.');
    CheckCondition((qData.FieldByName('DAYLY_PAYMENT').AsString <> '') and (qData.FieldByName('DAYLY_PAYMENT_2').AsString = ''),
                   'Абонентская плата должна быть числом.');
    CheckCondition((qData.FieldByName('DAYLY_PAYMENT_LOCKED').AsString <> '') and (qData.FieldByName('DAYLY_PAYMENT_LOCKED_2').AsString = ''),
                   'Абонентская плата (заблок) должна быть числом.');
    // целое число
    CheckCondition((qData.FieldByName('PHONE_NUMBER_TYPE').AsString <> '') and (qData.FieldByName('PHONE_NUMBER_TYPE_2').AsString = ''),
                   'Тип телефонного номера должен быть целым числом.');
    CheckCondition((qData.FieldByName('IS_ACTIVE').AsString <> '') and (qData.FieldByName('IS_ACTIVE_2').AsString = ''),
                   'Признак активности тарифа должен быть целым числом.');
    CheckCondition((qData.FieldByName('CONTRACT_NUM').AsString <> '') and (qData.FieldByName('CONTRACT_NUM_2').AsString = ''),
                   'Номер контракта должен быть целым числом.');
    // дата
    CheckCondition((qData.FieldByName('DOCUM_DATE').AsString <> '') and (qData.FieldByName('DOCUM_DATE_2').AsString = ''),
                   'Дата документа должна быть датой в формате DD.MM.YYYY');
    CheckCondition((qData.FieldByName('BDATE').AsString <> '') and (qData.FieldByName('BDATE_2').AsString = ''),
                   'Дата рождения должна быть датой в формате DD.MM.YYYY');
    CheckCondition((qData.FieldByName('PASSPORT_DATE').AsString <> '') and (qData.FieldByName('PASSPORT_DATE_2').AsString = ''),
                   'Дата выдачи паспорта должна быть датой в формате DD.MM.YYYY');
  end;

  Result := vRes;
end;

procedure TLoadDataFrm.grDataDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  if qData.FieldByName('ERROR_TEXT').AsString <> '' then
    (Sender as TCRDBGrid).Canvas.Font.Color := clRed;

  (Sender as TCRDBGrid).DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TLoadDataFrm.aOpenFileExecute(Sender: TObject);
begin
  DoOpenFile(eFileName.Text);
end;

function TLoadDataFrm.DoOpenFile(const pFileName : String) : boolean;
begin
  Result := False;
  if not FileExists(pFileName) then
    MessageDlg('Не возможно загрузить файл "'+pFileName+'". Файл не существует.', mtError, [mbOK], 0)
  else
  begin
    if DoLoadDataFromExcel(pFileName) then
    begin
      FillDetails;
      DoShowErrors;
      //qDetails.IndexFieldNames := 'NUM';
      grDetails.Columns.Items[0].SortOrder := soAsc;
      grDetails.Columns.Items[0].SortSequence := 1;
      qDetails.First;
      Result := True;
    end;
  end;
end;

function TLoadDataFrm.NormalizePhoneNumber(const pPhoneNumber : String) : String;
begin
  Result := StringReplace(
              StringReplace(pPhoneNumber, ' ', '', [rfReplaceAll, rfIgnoreCase])
            , '+7', '8', [rfReplaceAll, rfIgnoreCase]);
end;

// добавить контракт
function TLoadDataFrm.SaveContract(const pAbonentId : Variant) : Variant;
var
  vID : Variant;
begin
  Result := Null;
  try
    vID := FindId(qData.FieldByName('CONTRACT_NUM_2').AsString, 'CONTRACTS', 'CONTRACT_NUM', 'CONTRACT_ID');
    if VarToStr(vID) = '' then
    begin
      qGetNewContractId.ExecSQL;

      qAddContract.ParamByName('CONTRACT_ID').Value := qGetNewContractId.ParamByName('RESULT').Value;
      qAddContract.ParamByName('CONTRACT_NUM').Value := qData.FieldByName('CONTRACT_NUM_2').Value;
      qAddContract.ParamByName('CONTRACT_DATE').Value := qData.FieldByName('DOCUM_DATE_2').Value;
      qAddContract.ParamByName('FILIAL_ID').Value := qData.FieldByName('FILIAL_ID').Value;
      qAddContract.ParamByName('OPERATOR_ID').Value := qData.FieldByName('OPERATOR_ID').Value;
      qAddContract.ParamByName('PHONE_NUMBER_FEDERAL').Value := NormalizePhoneNumber(qData.FieldByName('PHONE_NUMBER_FEDERAL').AsString);
      qAddContract.ParamByName('PHONE_NUMBER_CITY').Value := NormalizePhoneNumber(qData.FieldByName('PHONE_NUMBER_CITY').AsString);
      qAddContract.ParamByName('PHONE_NUMBER_TYPE').Value := qData.FieldByName('PHONE_NUMBER_TYPE_2').Value;
      qAddContract.ParamByName('TARIFF_ID').Value := qData.FieldByName('TARIFF_ID').Value;
      qAddContract.ParamByName('SIM_NUMBER').Value := qData.FieldByName('SIM_NUMBER').Value;
      //qAddContract.ParamByName('SERVICE_ID').Value := qData.FieldByName('SERVICE_ID').Value;
      qAddContract.ParamByName('DISCONNECT_LIMIT').Value := qData.FieldByName('DISCONNECT_LIMIT_2').Value;
      //qAddContract.ParamByName('CONFIRMED').Value := qData.FieldByName('CONFIRMED_2').Value;
      qAddContract.ParamByName('ABONENT_ID').Value := pAbonentId;
      qAddContract.ParamByName('RECEIVED_SUM').Value := qData.FieldByName('SUM_GET_2').Value;
      qAddContract.ParamByName('START_BALANCE').Value := qData.FieldByName('START_BALANCE_2').Value;
      qAddContract.ParamByName('GOLD_NUMBER_SUM').Value := qData.FieldByName('GOLD_NUMBER_SUM_2').Value;
      qAddContract.ExecSQL;

      Result := qAddContract.ParamByName('CONTRACT_ID').Value;
    end
    else
    begin
      Result := vID;

      qUpdateContract.ParamByName('CONTRACT_ID').Value := vID;
      //qUpdateContract.ParamByName('CONTRACT_NUM').Value := qData.FieldByName('CONTRACT_NUM_2').Value;
      qUpdateContract.ParamByName('CONTRACT_DATE').Value := qData.FieldByName('DOCUM_DATE_2').Value;
      qUpdateContract.ParamByName('FILIAL_ID').Value := qData.FieldByName('FILIAL_ID').Value;
      qUpdateContract.ParamByName('OPERATOR_ID').Value := qData.FieldByName('OPERATOR_ID').Value;
      qUpdateContract.ParamByName('PHONE_NUMBER_FEDERAL').Value := NormalizePhoneNumber(qData.FieldByName('PHONE_NUMBER_FEDERAL').AsString);
      qUpdateContract.ParamByName('PHONE_NUMBER_CITY').Value := NormalizePhoneNumber(qData.FieldByName('PHONE_NUMBER_CITY').AsString);
      qUpdateContract.ParamByName('PHONE_NUMBER_TYPE').Value := qData.FieldByName('PHONE_NUMBER_TYPE_2').Value;
      qUpdateContract.ParamByName('TARIFF_ID').Value := qData.FieldByName('TARIFF_ID').Value;
      qUpdateContract.ParamByName('SIM_NUMBER').Value := qData.FieldByName('SIM_NUMBER').Value;
      //qUpdateContract.ParamByName('SERVICE_ID').Value := qData.FieldByName('SERVICE_ID').Value;
      qUpdateContract.ParamByName('DISCONNECT_LIMIT').Value := qData.FieldByName('DISCONNECT_LIMIT_2').Value;
      //qUpdateContract.ParamByName('CONFIRMED').Value := qData.FieldByName('CONFIRMED_2').Value;
      qUpdateContract.ParamByName('ABONENT_ID').Value := pAbonentId;
      qUpdateContract.ParamByName('RECEIVED_SUM').Value := qData.FieldByName('SUM_GET_2').Value;
      qUpdateContract.ParamByName('START_BALANCE').Value := qData.FieldByName('START_BALANCE_2').Value;
      qUpdateContract.ParamByName('GOLD_NUMBER_SUM').Value := qData.FieldByName('GOLD_NUMBER_SUM_2').Value;
      qUpdateContract.ExecSQL;
    end;
  except
    on e : exception do
      MessageDlg('Ошибка при добавлении/изменении договора № "'+qData.FieldByName('CONTRACT_NUM').AsString+'".'#13#10+e.Message, mtError, [mbOK], 0);
  end;

end;

// добавить абонента и вернуть ABONENT_ID
function TLoadDataFrm.AddAbonent : Variant;
begin
  Result := Null;
  try
    qGetNewAbonentId.ExecSQL;

    qAddAbonent.ParamByName('ABONENT_ID').Value    := qGetNewAbonentId.ParamByName('RESULT').Value;
    qAddAbonent.ParamByName('SURNAME').Value       := qData.FieldByName('SURNAME').Value;
    qAddAbonent.ParamByName('NAME').Value          := qData.FieldByName('NAME').Value;
    qAddAbonent.ParamByName('PATRONYMIC').Value    := qData.FieldByName('PATRONYMIC').Value;
    qAddAbonent.ParamByName('BDATE').Value         := qData.FieldByName('BDATE_2').Value;
    qAddAbonent.ParamByName('PASSPORT_SER').Value  := qData.FieldByName('PASSPORT_SER').Value;
    qAddAbonent.ParamByName('PASSPORT_NUM').Value  := qData.FieldByName('PASSPORT_NUM').Value;
    qAddAbonent.ParamByName('PASSPORT_DATE').Value := qData.FieldByName('PASSPORT_DATE_2').Value;
    qAddAbonent.ParamByName('PASSPORT_GET').Value  := qData.FieldByName('PASSPORT_GET').Value;
    qAddAbonent.ParamByName('CITIZENSHIP').Value   := qData.FieldByName('CITIZENSHIP').Value;
    qAddAbonent.ParamByName('COUNTRY_ID').Value    := qData.FieldByName('COUNTRY_ID').Value;
    qAddAbonent.ParamByName('REGION_ID').Value     := qData.FieldByName('REGION_ID').Value;
    qAddAbonent.ParamByName('REGION_NAME').Value   := qData.FieldByName('REGION_NAME').Value;
    qAddAbonent.ParamByName('CITY_NAME').Value     := qData.FieldByName('CITY_NAME').Value;
    qAddAbonent.ParamByName('STREET_NAME').Value   := qData.FieldByName('STREET_NAME').Value;
    qAddAbonent.ParamByName('HOUSE').Value         := qData.FieldByName('HOUSE').Value;
    qAddAbonent.ParamByName('KORPUS').Value        := qData.FieldByName('KORPUS').Value;
    qAddAbonent.ParamByName('APARTMENT').Value     := qData.FieldByName('APARTMENT').Value;
    qAddAbonent.ParamByName('CONTACT_INFO').Value  := qData.FieldByName('CONTACT_INFO').Value;
    qAddAbonent.ParamByName('CODE_WORD').Value     := qData.FieldByName('CODE_WORD').Value;
    if Trim(AnsiUpperCase(qData.FieldByName('IS_VIP_NAME').AsString)) = 'ДА' then
      qAddAbonent.ParamByName('IS_VIP').Value        := 1
    else if Trim(AnsiUpperCase(qData.FieldByName('IS_VIP_NAME').AsString)) = 'НЕТ' then
      qAddAbonent.ParamByName('IS_VIP').Value        := 0
    else
      qAddAbonent.ParamByName('IS_VIP').Value        := qData.FieldByName('IS_VIP_NAME').Value;
    qAddAbonent.ParamByName('EMAIL').Value         := qData.FieldByName('EMAIL').Value;
    qAddAbonent.ExecSQL;

    Result := qAddAbonent.ParamByName('ABONENT_ID').Value;
  except
    on e : exception do
      MessageDlg('Ошибка при добавлении абонента "'+qData.FieldByName('SURNAME').AsString+'",'+
                                               ' "'+qData.FieldByName('NAME').AsString+'"'+
                                               ' "'+qData.FieldByName('PATRONYMIC').AsString+'".'#13#10+e.Message, mtError, [mbOK], 0);
  end;
end;

// добавить платеж
function TLoadDataFrm.SavePayment : Variant;
var vContractId : Variant;
    vID : Variant;
begin
  Result := Null;
  try
    vContractId := FindId(qData.FieldByName('CONTRACT_NUM_2').AsString, 'CONTRACTS', 'CONTRACT_NUM', 'CONTRACT_ID');
    if VarToStr(vContractId) <> '' then
    begin
      vID := FindPaymentId(vContractId, qData.FieldByName('DOCUM_DATE_2').Value);
      // не нашли, добавляем
      if VarToStr(vID) = '' then
      begin
        qNewPaymentId.ExecSQL;

        qAddPayment.ParamByName('RECEIVED_PAYMENT_ID').Value     := qNewPaymentId.ParamByName('RESULT').Value;
        qAddPayment.ParamByName('PHONE_NUMBER').Value            := NormalizePhoneNumber(qData.FieldByName('PHONE_NUMBER_FEDERAL').AsString);
        qAddPayment.ParamByName('PAYMENT_SUM').Value             := qData.FieldByName('SUM_GET_2').Value;
        qAddPayment.ParamByName('PAYMENT_DATE_TIME').Value       := qData.FieldByName('DOCUM_DATE_2').Value;
        qAddPayment.ParamByName('CONTRACT_ID').Value             := vContractId;
        qAddPayment.FieldByName('IS_CONTRACT_PAYMENT').AsInteger := 0;
        qAddPayment.ParamByName('FILIAL_ID').Value               := qData.FieldByName('FILIAL_ID').Value;
        qAddPayment.ExecSQL;

        Result := qAddPayment.ParamByName('RECEIVED_PAYMENT_ID').Value;
      end
      else // нашли обновляем
      begin
        Result := vID;

        qUpdatePayment.ParamByName('RECEIVED_PAYMENT_ID').Value     := vID;
        qUpdatePayment.ParamByName('PHONE_NUMBER').Value            := NormalizePhoneNumber(qData.FieldByName('PHONE_NUMBER_FEDERAL').AsString);
        qUpdatePayment.ParamByName('PAYMENT_SUM').Value             := qData.FieldByName('SUM_GET_2').Value;
        //qUpdatePayment.ParamByName('PAYMENT_DATE_TIME').Value       := qData.FieldByName('DOCUM_DATE_2').Value;
        //qUpdatePayment.ParamByName('CONTRACT_ID').Value             := vContractId;
        //qUpdatePayment.FieldByName('IS_CONTRACT_PAYMENT').AsInteger := 0;
        qUpdatePayment.ParamByName('FILIAL_ID').Value               := qData.FieldByName('FILIAL_ID').Value;
        qUpdatePayment.ExecSQL;
      end;
    end
    else
    begin
      MessageDlg('Ошибка при добавлении платежа по договору № "'+qData.FieldByName('CONTRACT_NUM').AsString
               +'". Договор не найден.', mtError, [mbOK], 0);
      Result := Null;
    end;
  except
    on e : exception do
      MessageDlg('Ошибка при добавлении/изменении платежа по договору № "'+qData.FieldByName('CONTRACT_NUM').AsString
               +'" от "'+qData.FieldByName('DOCUM_DATE').AsString + '".'#13#10+e.Message, mtError, [mbOK], 0);
  end;
end;

// добавить документ расторжения договора
function TLoadDataFrm.SaveContractCancel : Variant;
var vContractId : Variant;
    vID : Variant;
begin
  Result := Null;
  try
    vContractId := FindId(qData.FieldByName('CONTRACT_NUM_2').AsString, 'CONTRACTS', 'CONTRACT_NUM', 'CONTRACT_ID');
    if VarToStr(vContractId) <> '' then
    begin
      vID := FindContractCancelId(vContractId, qData.FieldByName('DOCUM_DATE_2').Value);
      // не нашли, добавляем
      if VarToStr(vID) = '' then
      begin
        qNewCantractCancelId.ExecSQL;

        qAddContractCancel.ParamByName('CONTRACT_CANCEL_ID').Value      := qNewCantractCancelId.ParamByName('RESULT').Value;
        qAddContractCancel.ParamByName('CONTRACT_ID').Value             := vContractId;
        qAddContractCancel.ParamByName('FILIAL_ID').Value               := qData.FieldByName('FILIAL_ID').Value;
        qAddContractCancel.ParamByName('CONTRACT_CANCEL_DATE').Value    := qData.FieldByName('DOCUM_DATE_2').Value;
        qAddContractCancel.ParamByName('CONTRACT_CANCEL_TYPE_ID').Value := qData.FieldByName('CONTRACT_CANCEL_TYPE_ID').Value;
        if qData.FieldByName('SUM_GET_2').AsFloat >= 0 then
        begin
          qAddContractCancel.ParamByName('SUM_GET').Value             := qData.FieldByName('SUM_GET_2').Value;
          qAddContractCancel.ParamByName('SUM_PUT').Value             := Null;
        end
        else
        begin
          qAddContractCancel.ParamByName('SUM_GET').Value             := Null;
          qAddContractCancel.ParamByName('SUM_PUT').Value             := (-1)*qData.FieldByName('SUM_GET_2').AsFloat;
        end;

        qAddContractCancel.ExecSQL;

        Result := qAddContractCancel.ParamByName('CONTRACT_CANCEL_ID').Value;
      end
      else // если нашли, изменяем
      begin
        Result := vID;

        qUpdateContractCancel.ParamByName('CONTRACT_CANCEL_ID').Value      := vID;
        //qUpdateContractCancel.ParamByName('CONTRACT_ID').Value             := vContractId;
        qUpdateContractCancel.ParamByName('FILIAL_ID').Value               := qData.FieldByName('FILIAL_ID').Value;
        //qUpdateContractCancel.ParamByName('CONTRACT_CANCEL_DATE').Value    := qData.FieldByName('DOCUM_DATE_2').Value;
        qUpdateContractCancel.ParamByName('CONTRACT_CANCEL_TYPE_ID').Value := qData.FieldByName('CONTRACT_CANCEL_TYPE_ID').Value;
        if qData.FieldByName('SUM_GET_2').AsFloat >= 0 then
        begin
          qUpdateContractCancel.ParamByName('SUM_GET').Value             := qData.FieldByName('SUM_GET_2').Value;
          qUpdateContractCancel.ParamByName('SUM_PUT').Value             := Null;
        end
        else
        begin
          qUpdateContractCancel.ParamByName('SUM_GET').Value             := Null;
          qUpdateContractCancel.ParamByName('SUM_PUT').Value             := (-1)*qData.FieldByName('SUM_GET_2').AsFloat;
        end;

        qUpdateContractCancel.ExecSQL;
      end;
    end
    else
    begin
      Result := Null;
      MessageDlg('Ошибка при добавлении/изменении документа расторжения договора № "'+qData.FieldByName('CONTRACT_NUM').AsString
                             +'. Договор не найден.', mtError, [mbOK], 0);
    end;
  except
    on e : exception do
      MessageDlg('Ошибка при добавлении/изменении документа расторжения договора № "'+qData.FieldByName('CONTRACT_NUM').AsString
                             +'.'#13#10+e.Message, mtError, [mbOK], 0);
  end;
end;

// добавить документ изменения договора
function TLoadDataFrm.SaveContractChange(const pTypeDoc : Integer) : Variant;
var vContractId : Variant;
    vID : Variant;
begin
  Result := Null;
  try
    vContractId := FindId(qData.FieldByName('CONTRACT_NUM_2').AsString, 'CONTRACTS', 'CONTRACT_NUM', 'CONTRACT_ID');
    if VarToStr(vContractId) <> '' then
    begin
      vID := FindContractChangeId(vContractId, qData.FieldByName('DOCUM_DATE_2').Value, pTypeDoc);
      // не нашли, добавляем
      if VarToStr(vID) = '' then
      begin
        qNewCantractChangeId.ExecSQL;

        qAddContractChange.ParamByName('CONTRACT_CHANGE_ID').Value      := qNewCantractChangeId.ParamByName('RESULT').Value;
        qAddContractChange.ParamByName('CONTRACT_ID').Value             := vContractId;
        qAddContractChange.ParamByName('DOCUM_TYPE_ID').Value           := qData.FieldByName('DOCUM_TYPE_ID').Value;
        qAddContractChange.ParamByName('CONTRACT_CHANGE_DATE').Value    := qData.FieldByName('DOCUM_DATE_2').Value;
        qAddContractChange.ParamByName('FILIAL_ID').Value               := qData.FieldByName('FILIAL_ID').Value;
        qAddContractChange.ParamByName('SUM_GET').Value                 := qData.FieldByName('SUM_GET_2').Value;
        // оператор не может меняться при изменении договора
        qAddContractChange.ParamByName('OPERATOR_ID').Value             := Null; // qData.FieldByName('OPERATOR_ID').Value;

        // заполняем только те поля, которые должны быть в этих типах изменения договора
        //  если загрузим другие поля, то рискуем получить в базе изменения договоров,
        //  которые не отображаются в интерефейсе и которые не сможем изменить через интерфейс
        case pTypeDoc of
          TYPE_DOC_CHANGE_SIM :
            begin
              qAddContractChange.ParamByName('PHONE_NUMBER_FEDERAL').Value    := Null;
              qAddContractChange.ParamByName('PHONE_NUMBER_CITY').Value       := Null;
              qAddContractChange.ParamByName('PHONE_NUMBER_TYPE').Value       := Null;
              qAddContractChange.ParamByName('SIM_NUMBER').Value              := qData.FieldByName('SIM_NUMBER').Value;
              qAddContractChange.ParamByName('TARIFF_ID').Value               := Null;
            end;
          TYPE_DOC_CHANGE_PHONE_NUM :
            begin
              qAddContractChange.ParamByName('PHONE_NUMBER_FEDERAL').Value    := NormalizePhoneNumber(qData.FieldByName('PHONE_NUMBER_FEDERAL').AsString);
              qAddContractChange.ParamByName('PHONE_NUMBER_CITY').Value       := NormalizePhoneNumber(qData.FieldByName('PHONE_NUMBER_CITY').AsString);
              qAddContractChange.ParamByName('PHONE_NUMBER_TYPE').Value       := qData.FieldByName('PHONE_NUMBER_TYPE_2').Value;
              qAddContractChange.ParamByName('SIM_NUMBER').Value              := qData.FieldByName('SIM_NUMBER').Value;
              qAddContractChange.ParamByName('TARIFF_ID').Value               := Null;
            end;
          TYPE_DOC_CHANGE_TARIFF :
            begin
              qAddContractChange.ParamByName('PHONE_NUMBER_FEDERAL').Value    := Null;
              qAddContractChange.ParamByName('PHONE_NUMBER_CITY').Value       := Null;
              qAddContractChange.ParamByName('PHONE_NUMBER_TYPE').Value       := Null;
              qAddContractChange.ParamByName('SIM_NUMBER').Value              := Null;
              qAddContractChange.ParamByName('TARIFF_ID').Value               := qData.FieldByName('TARIFF_ID').Value;
            end;
        end;
        qAddContractChange.ExecSQL;

        Result := qAddContractChange.ParamByName('CONTRACT_CHANGE_ID').Value;
      end
      else
      begin
        Result := vID;

        qUpdateContractChange.ParamByName('CONTRACT_CHANGE_ID').Value      := vID;
        //qUpdateContractChange.ParamByName('CONTRACT_ID').Value             := vContractId;
        //qUpdateContractChange.ParamByName('DOCUM_TYPE_ID').Value           := qData.FieldByName('DOCUM_TYPE_ID').Value;
        //qUpdateContractChange.ParamByName('CONTRACT_CHANGE_DATE').Value    := qData.FieldByName('DOCUM_DATE_2').Value;
        qUpdateContractChange.ParamByName('FILIAL_ID').Value               := qData.FieldByName('FILIAL_ID').Value;
        qUpdateContractChange.ParamByName('SUM_GET').Value                 := qData.FieldByName('SUM_GET_2').Value;
        // оператор не может меняться при изменении договора
        //qUpdateContractChange.ParamByName('OPERATOR_ID').Value             := Null; // qData.FieldByName('OPERATOR_ID').Value;

        // заполняем только те поля, которые должны быть в этих типах изменения договора
        //  если загрузим другие поля, то рискуем получить в базе изменения договоров,
        //  которые не отображаются в интерефейсе и которые не сможем изменить через интерфейс
        case pTypeDoc of
          TYPE_DOC_CHANGE_SIM :
            begin
              qUpdateContractChange.ParamByName('PHONE_NUMBER_FEDERAL').Value    := Null;
              qUpdateContractChange.ParamByName('PHONE_NUMBER_CITY').Value       := Null;
              qUpdateContractChange.ParamByName('PHONE_NUMBER_TYPE').Value       := Null;
              qUpdateContractChange.ParamByName('SIM_NUMBER').Value              := qData.FieldByName('SIM_NUMBER').Value;
              qUpdateContractChange.ParamByName('TARIFF_ID').Value               := Null;
            end;
          TYPE_DOC_CHANGE_PHONE_NUM :
            begin
              qUpdateContractChange.ParamByName('PHONE_NUMBER_FEDERAL').Value    := NormalizePhoneNumber(qData.FieldByName('PHONE_NUMBER_FEDERAL').AsString);
              qUpdateContractChange.ParamByName('PHONE_NUMBER_CITY').Value       := NormalizePhoneNumber(qData.FieldByName('PHONE_NUMBER_CITY').AsString);
              qUpdateContractChange.ParamByName('PHONE_NUMBER_TYPE').Value       := qData.FieldByName('PHONE_NUMBER_TYPE_2').Value;
              qUpdateContractChange.ParamByName('SIM_NUMBER').Value              := qData.FieldByName('SIM_NUMBER').Value;
              qUpdateContractChange.ParamByName('TARIFF_ID').Value               := Null;
            end;
          TYPE_DOC_CHANGE_TARIFF :
            begin
              qUpdateContractChange.ParamByName('PHONE_NUMBER_FEDERAL').Value    := Null;
              qUpdateContractChange.ParamByName('PHONE_NUMBER_CITY').Value       := Null;
              qUpdateContractChange.ParamByName('PHONE_NUMBER_TYPE').Value       := Null;
              qUpdateContractChange.ParamByName('SIM_NUMBER').Value              := Null;
              qUpdateContractChange.ParamByName('TARIFF_ID').Value               := qData.FieldByName('TARIFF_ID').Value;
            end;
        end;
        qUpdateContractChange.ExecSQL;
      end;
    end
    else
    begin
      Result := Null;
      MessageDlg('Ошибка при добавлении документа изменения договора № "'+qData.FieldByName('CONTRACT_NUM').AsString
                             +'. Договор не найден.', mtError, [mbOK], 0);
    end;
  except
    on e : exception do
      MessageDlg('Ошибка при добавлении документа изменения договора № "'+qData.FieldByName('CONTRACT_NUM').AsString
                             +'.'#13#10+e.Message, mtError, [mbOK], 0);
  end;
end;

procedure TLoadDataFrm.aLoadFileExecute(Sender: TObject);
var bm : TBookMark;
    vLoadedCount : Integer;
    vDocumTypeId : Integer;
    //vIgnoreAll : boolean;
    vAbonentId : Variant;
begin
  vLoadedCount := 0;
  if qData.Active then
  begin
    if qData.RecordCount = 0 then
      MessageDlg('Нет документов для загрузки.', mtError, [mbOK], 0)
    else
    begin
      qData.DisableControls;
      bm := qData.GetBookmark;
      try
        qData.First;
        while not qData.Eof do
        begin
          // документы с ошибками не загружаем
          if qData.FieldByName('ERROR_TEXT').AsString = '' then
          begin
            if qData.FieldByName('DOCUM_TYPE_ID').IsNull then
              vDocumTypeId := -1
            else
              vDocumTypeId := qData.FieldByName('DOCUM_TYPE_ID').AsInteger;

            case vDocumTypeId of
              TYPE_DOC_PAYMENT :
                begin
                  if VarToStr(SavePayment()) <> '' then
                    vLoadedCount := vLoadedCount + 1;
                end;
              TYPE_DOC_CONTRACT :
                begin
                  if qData.FieldByName('ABONENT_ID').AsString = '' then
                    vAbonentId := AddAbonent()
                  else
                    vAbonentId := qData.FieldByName('ABONENT_ID').Value;

                  if (VarToStr(vAbonentId) <> '') and (VarToStr(SaveContract(vAbonentId)) <> '') then
                    vLoadedCount := vLoadedCount + 1;
                end;
              TYPE_DOC_CHANGE_SIM :
                begin
                  if VarToStr(SaveContractChange(TYPE_DOC_CHANGE_SIM)) <> '' then
                    vLoadedCount := vLoadedCount + 1;
                end;
              TYPE_DOC_CHANGE_PHONE_NUM :
                begin
                  if VarToStr(SaveContractChange(TYPE_DOC_CHANGE_PHONE_NUM)) <> '' then
                    vLoadedCount := vLoadedCount + 1;
                end;
              TYPE_DOC_CHANGE_TARIFF :
                begin
                  if VarToStr(SaveContractChange(TYPE_DOC_CHANGE_TARIFF)) <> '' then
                    vLoadedCount := vLoadedCount + 1;
                end;
              TYPE_DOC_CONTRACT_CANCEL :
                begin
                  if VarToStr(SaveContractCancel()) <> '' then
                    vLoadedCount := vLoadedCount + 1;
                end;
            else
              MessageDlg('Ошибка загрузки. Тип документа с кодом "'+qData.FieldByName('DOCUM_TYPE_ID').AsString+'" не поддерживается.', mtError, [mbOK], 0)
            end;
          end;

          qData.Next;
        end;
        MessageDlg('Загрузка завершена. Загружено документов '+IntToStr(vLoadedCount)+' из '+IntToStr(qData.ReCordCount)+'.', mtInformation, [mbOK], 0)
      finally
        qData.GotoBookmark(bm);
        qData.FreeBookmark(bm);
        qData.EnableControls;
      end;
      Self.Close;
    end;
  end;
end;

end.
