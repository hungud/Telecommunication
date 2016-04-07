unit MassRemovalDopStatus;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, MemDS, VirtualTable,
  Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids, CRGrid, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ActnList, ActiveX, IntecExportGrid, CRStrUtils, Ora, DBAccess,
  Vcl.ComCtrls;

type
  TMassRemovalDopStatusForm = class(TForm)
    gGrid: TCRDBGrid;
    panButton: TPanel;
    vtMain: TVirtualTable;
    dsMain: TDataSource;
    bLoadPhone: TBitBtn;
    bRemoveDopStatus: TBitBtn;
    bInfo: TBitBtn;
    aList: TActionList;
    aLoadPhone: TAction;
    aRemoveDopStatus: TAction;
    aViewInfo: TAction;
    vtMainPHONE_NUMBER: TStringField;
    vtMainDOP_STATUS_NAME: TStringField;
    dgOpen: TOpenDialog;
    mData: TMemo;
    vtMainNOTE: TStringField;
    vtMainCONTRACT_DATE: TDateField;
    vtMainSTATUS_NAME: TStringField;
    qContracts: TOraQuery;
    qAccStatus: TOraQuery;
    bDeleteRecord: TBitBtn;
    aDeleteRecord: TAction;
    qRemoveDopStatus: TOraQuery;
    vtMainCONTRACT_ID: TIntegerField;
    ProgressBar: TProgressBar;
    procedure aLoadPhoneExecute(Sender: TObject);
    procedure aRemoveDopStatusExecute(Sender: TObject);
    procedure aViewInfoExecute(Sender: TObject);
    procedure aDeleteRecordExecute(Sender: TObject);
  private
    { Private declarations }
  public
    procedure FillVirtTable;
    procedure SetProgress(i: integer);
    { Public declarations }
  end;

var
  MassRemovalDopStatusForm: TMassRemovalDopStatusForm;

  procedure DoReportMassRemovalDopStatus;

implementation

{$R *.dfm}

uses ComObj, ShowUserStat;

procedure DoReportMassRemovalDopStatus;
var ReportFrm : TMassRemovalDopStatusForm;
begin
  ReportFrm := TMassRemovalDopStatusForm.Create(Nil);
  try
    ReportFrm.aDeleteRecord.Enabled := false;
    ReportFrm.aRemoveDopStatus.Enabled := false;
    ReportFrm.aViewInfo.Enabled := false;
    ReportFrm.ShowModal;
  finally
    ReportFrm.Free;
  end;
end;

procedure TMassRemovalDopStatusForm.SetProgress(i: integer);
begin
  ProgressBar.Position:=I;
  ProgressBar.Update;
  Application.ProcessMessages;
end;

//загрузка номеров
procedure TMassRemovalDopStatusForm.aLoadPhoneExecute(Sender: TObject);
var
  FileName: TFileName;
  fs : TFileStream;
  Parser: Variant;
  ParsedArray: Variant;
  ms: TBytesStream;
  VarBytes : Variant;
  TextData: String;
  StreamAdapter : TStreamAdapter;
begin
  mData.Clear;
  Caption := 'Загрузка номеров с доп. статусом';
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

      if TextData = '' then
      begin
        bLoadPhone.Enabled := False;
        ShowMessage('Файл не содержит информации. Загрузка не разрешена.');
      end
      else
      begin
        mData.Lines.Text := TextData;
        //заполнение виртуальной таблицы данными из memo
        FillVirtTable;
        //показываем кнопки
        aDeleteRecord.Enabled := true;
        aRemoveDopStatus.Enabled := true;
        aViewInfo.Enabled := true;
      end;
    end;
  end;
end;

procedure TMassRemovalDopStatusForm.FillVirtTable;
var
  i, k, l: integer;
  Line, pPhone: string;
  res, checkFig: boolean;
  pContract_date: Variant;
  pStatus_name, pDop_Status_name, pNote: string;
  pContract_id: variant;
begin
  vtMain.DisableControls;
  vtMain.Clear;
  vtMain.Active := true;
  l := 0;
  ProgressBar.Max:= mData.Lines.Count-1;
  //пробегаем по всем строкам Memo
  for i := 1 to mData.Lines.Count-1 do
  begin
    Line := mData.Lines[i];
    if Line <> #9+#9+#9+#9+#9+#9+#9+#9+#9 then
    begin
      if GetToken(Line, 1) <> '' then
      begin
        pPhone := GetToken(Line, 1);
        //определяем корректность номера
        checkFig := true;
        //проверяем чтобы в строке были только цифры
        for k:=1 to Length(pPhone) do
          if not (pPhone[k] in ['0'..'9']) then
          begin
            checkFig := false;
            break;
          end;

        //пропускаем записи с символами
        if checkFig then
        begin
          res := false;
          //проверяем длину номера (должно быть 10 цифр, может быть больше из за 7 или 8)
          if (Length(pPhone) >= 10) and (Length(pPhone) < 12) then
          begin
            if Length(pPhone) = 11 then
              pPhone := Copy(pPhone, Length(pPhone)-9); //обрезаем номер
            res := true
          end;

          pContract_ID := null;
          pContract_date := null;
          pStatus_name := '';
          pDop_Status_name := '';
          pNote := '';
          //если номер введен корректно (данные с символами не учитываю совсем)
          if res then
          begin
            //определяем доп. параметры (дата договора, статус, доп. статус)
            qContracts.ParamByName('pPHONE_NUMBER').AsString := pPhone;
            qContracts.Close;
            qContracts.Open;

            if not qContracts.IsEmpty then
            begin
              if qContracts.FieldByName('CONTRACT_ID').IsNull then
                pNote := 'По номеру отсутствует контракт. '
              else
              begin
                pContract_ID := qContracts.FieldByName('CONTRACT_ID').AsInteger;
                if qContracts.FieldByName('CONTRACT_DATE').IsNull then
                  pNote := 'По номеру отсутствует дата контракта. '
                else
                  pContract_date := qContracts.FieldByName('CONTRACT_DATE').AsDateTime;
                if qContracts.FieldByName('DOP_STATUS').IsNull then
                  pNote := pNote + 'По номеру отсутствует доп. статус. '
                else
                  pDop_Status_name := qContracts.FieldByName('DOP_STATUS_NAME').AsString;
              end;
            end
            else
              pNote := pNote + 'По номеру отсутствует контракт. ';

            //статус
            qAccStatus.ParamByName('pPHONE_NUMBER').AsString := pPhone;
            qAccStatus.Close;
            qAccStatus.Open;

            if not qAccStatus.IsEmpty then
            begin
              if qAccStatus.FieldByName('STATUS_ID').IsNull then
                pNote := pNote + 'По номеру отсутствует статус в текущем месяце. '
              else
                pStatus_name := qAccStatus.FieldByName('COMMENT_CLENT').AsString;
            end
            else
              pNote := pNote + 'По номеру отсутствует статус в текущем месяце. ';
          end
          else
            if checkFig then
              pNote := pNote + 'Номер введен некорректно.';

          //вставка в вирт. таблицу
          vtMain.AppendRecord([pPhone, pContract_ID, pContract_date, pStatus_name,
            pDop_Status_name, pNote]);
        end;
      end;
    end;
    inc(l);
    SetProgress(l);
  end;
  vtMain.EnableControls;
end;

//удаление доп. статусов с номеров
procedure TMassRemovalDopStatusForm.aRemoveDopStatusExecute(Sender: TObject);
var i, k, l: integer;
begin
  //пробегаем по всем корректно введенным номерам в виртуальной таблице и удаляем доп. статус
  vtMain.DisableControls;
  l := 0;
  ProgressBar.Max:= vtMain.RecordCount;
  k := vtMain.RecNo;
  vtMain.First;
  while not vtMain.Eof do
  begin
    if trim(vtMainNOTE.AsString) = '' then
    begin
      //удаление доп. статуса
      qRemoveDopStatus.ParamByName('pPHONE_NUMBER').AsString := vtMainPHONE_NUMBER.AsString;
      qRemoveDopStatus.ParamByName('pCONTRACT_ID').AsInteger := vtMainCONTRACT_ID.AsInteger;
      qRemoveDopStatus.ExecSQL;
      //обновление доп. статуса в виртуальной таблице
      qContracts.ParamByName('pPHONE_NUMBER').AsString := vtMainPHONE_NUMBER.AsString;
      qContracts.Close;
      qContracts.Open;
      i := vtMain.RecNo;
      vtMain.Edit;
      vtMainDOP_STATUS_NAME.AsString := qContracts.FieldByName('DOP_STATUS_NAME').AsString;
      vtMain.RecNo := i;
    end;
    vtMain.Next;
    inc(l);
    SetProgress(l);
  end;
  vtMain.RecNo := k;
  showmessage('С корректно введенных номеров статусы сняты!');
  vtMain.EnableControls;
end;

//удаление записи из виртуальной таблицы
procedure TMassRemovalDopStatusForm.aDeleteRecordExecute(Sender: TObject);
begin
  vtMain.Locate('PHONE_NUMBER', vtMainPHONE_NUMBER.Value, []);
  vtMain.Delete;
end;

//информация по абоненту
procedure TMassRemovalDopStatusForm.aViewInfoExecute(Sender: TObject);
begin
  if (vtMain.RecordCount > 0) then
    if (vtMainNOTE.AsString = '') then
      ShowUserStatByPhoneNumber(vtMainPHONE_NUMBER.AsString,0)
    else
      showmessage('Номер введен некорректно!');
end;

end.
