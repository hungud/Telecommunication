unit ReportRecoveryCloseContracts;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Data.DB, MemDS, DBAccess,
  Ora, Vcl.Grids, Vcl.DBGrids, CRGrid, Vcl.DBCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  Vcl.ComCtrls, ShowUserStat, IntecExportGrid,
  VCL.FlexCel.Core, FlexCel.XlsAdapter, FlexCel.Report, FlexCel.Render,
  Data.Win.ADODB, sListBox, sCheckListBox, sPageControl,
  Excel2000, ComObj;

type
  TReportRecoveryCloseContractsFrm = class(TForm)
    pFilter: TPanel;
    btRefresh: TBitBtn;
    btLoadInExcel: TBitBtn;
    b1: TBitBtn;
    pGrid: TPanel;
    dsAccounts: TDataSource;
    qAccounts: TOraQuery;
    dsReportRecoveryCloseContracts: TDataSource;
    qReportRecoveryCloseContracts: TOraQuery;
    qReportRecoveryCloseContracts_OLD: TOraQuery;
    q1: TOraQuery;
    qPeriod: TOraQuery;
    dsPeriod: TOraDataSource;
    p1: TPanel;
    btn1: TButton;
    btn2: TButton;
    CLB_Accounts: TsCheckListBox;
    lbl3: TLabel;
    lbl1: TLabel;
    dblkcbbPeriodBegin: TDBLookupComboBox;
    dblkcbbPeriodEnd: TDBLookupComboBox;
    lbl4: TLabel;
    qPeriod2: TOraQuery;
    dsPeriod2: TOraDataSource;
    qLoadedAccountList: TOraQuery;
    qOTTOK: TOraQuery;
    qCONNECTIONS: TOraQuery;
    sPageControl1: TsPageControl;
    sTabSheet1: TsTabSheet;
    sTabSheet2: TsTabSheet;
    dsOTTOK: TDataSource;
    g2: TCRDBGrid;
    dsCONNECTIONS: TDataSource;
    g1: TCRDBGrid;
    procedure btRefreshClick(Sender: TObject);
    procedure btLoadInExcelClick(Sender: TObject);
    procedure b1Click(Sender: TObject);
    procedure chkAllAccountClick(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    function GetSelectedAccountList : string ;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ReportRecoveryCloseContractsFrm: TReportRecoveryCloseContractsFrm;
  procedure DoReportRecoveryCloseContracts;



implementation

uses IOUtils, ShellAPI;

{$R *.dfm}

procedure DoReportRecoveryCloseContracts;
var
  ReportFrm : TReportRecoveryCloseContractsFrm;
begin
  ReportFrm := TReportRecoveryCloseContractsFrm.Create(Nil);
  try
    // Заполнение списка заявок
    with ReportFrm do begin
      //dtBeginPerioYEAR_MONTH.Date := Date;
      qReportRecoveryCloseContracts.ParamByName('pYEAR_MONTH_BEGIN').Value := dblkcbbPeriodBegin.KeyField;
      qReportRecoveryCloseContracts.ParamByName('pYEAR_MONTH_END').Value := dblkcbbPeriodEnd.KeyField;

      // заполняем Список лицевых счетов
      qAccounts.Open;
      qAccounts.First;
      while not qAccounts.EOF do
      begin
        CLB_Accounts.Items.AddObject(
          qAccounts.FieldByName('LOGIN').AsString,
          Pointer(ReportFrm.qAccounts.FieldByName('ACCOUNT_ID').AsInteger)
          );
        ReportFrm.qAccounts.Next;
      end;

      qPeriod2.Close;
      qPeriod2.Open;
      qPeriod.Close;
      qPeriod.Open;
      //устанавливаем значение для периода
      dblkcbbPeriodBegin.KeyValue := qPeriod.FieldByName('YEAR_MONTH').Value;
      dblkcbbPeriodEnd.KeyValue := qPeriod2.FieldByName('YEAR_MONTH').Value;
      ShowModal;
    end;
  finally
    ReportFrm.Free;
  end;
end;

procedure TReportRecoveryCloseContractsFrm.b1Click(Sender: TObject);
begin
  if sPageControl1.ActivePageIndex = 0 then
    if qOTTOK.Active and (qOTTOK.RecordCount > 0) then
      ShowUserStatByPhoneNumber(qOTTOK.FieldByName('PHONE_NUMBER_FEDERAL').AsString, 0);

  if sPageControl1.ActivePageIndex = 1 then
    if qCONNECTIONS.Active and (qCONNECTIONS.RecordCount > 0) then
      ShowUserStatByPhoneNumber(qCONNECTIONS.FieldByName('PHONE_NUMBER_FEDERAL').AsString, 0);
end;

procedure TReportRecoveryCloseContractsFrm.btLoadInExcelClick(Sender: TObject);

  // Формируем имя файла, на случай если такой уже существует в каталоге
  function Get_TemplateName( i : Integer) : string;
  var
    vTempName : string;
  begin
    try
      Inc(i);
//      vTempName := 'Анализ базы номеров_' + FormatDateTime('yyyy_mm_dd', Date) + '_' + IntToStr(i) + '.xlsx';
      vTempName := 'Анализ базы номеров_' + FormatDateTime('yyyy_mm_dd', Date) + '_' + IntToStr(i) + '.xlsm';

      if not FileExists(vTempName) then
        Result := vTempName
      else
        Result := Get_TemplateName(i);
    except on E: Exception do
      Result := 'Анализ базы номеров'; //Если вдруг что не так, то такое имя
    end;
  end;

  procedure RunMacros(const pFileName : string);
    function CreateExcelApplication : ExcelApplication;
    const
      ExcelApplicationString = 'Excel.Application';
    begin
      try
        try
    //      ExcelApplication := IDispatch(GetActiveOleObject('Excel.Application')) As Excel97.ExcelApplication;
          Result := CreateOleObject(ExcelApplicationString) as Excel2000._Application;
        except
          Result := CreateOleObject(ExcelApplicationString) as Excel2000._Application;
    //      Result := CoExcelApplication.Create;
        end;
    //    ExcelLanguageID := Result.LanguageSettings.LanguageID[msoLanguageIDUI];
      except
        on E : Exception do
        begin
    //      ShowMessage('Error!');
          Raise Exception.Create('Ошибка создания книги Ms Excel. '+E.Message);
        end;
      end;
    end;

  var
    vExcelApp : ExcelApplication;
    vWorkbook : Excel2000._Workbook;
    vSheet : Excel2000._Worksheet;
    vRange : oleVariant;
    //ExcelApp : Variant;
    //Workbook : Variant;
  begin

    //vExcelApp := CreateExcelApplication;
    //ExcelApp.Visible[1] := True;
    //vWorkbook := vExcelApp.Workbooks.Add(pFileName, 0);
    {
    vExcelApp.Run('Transp', EmptyParam,	EmptyParam,	EmptyParam,	EmptyParam,	EmptyParam,	EmptyParam,	EmptyParam,	EmptyParam,	EmptyParam,	EmptyParam,	EmptyParam,	EmptyParam,	EmptyParam,	EmptyParam,	EmptyParam,	EmptyParam,	EmptyParam,	EmptyParam,	EmptyParam,	EmptyParam,	EmptyParam,	EmptyParam,	EmptyParam,	EmptyParam,	EmptyParam,	EmptyParam,	EmptyParam,	EmptyParam,	EmptyParam,	EmptyParam);
    //vWorkbook.Save(0); // ( Copy(pFileName, 1, length(pFileName)-1), 0);
    vWorkbook.SaveAs(Copy(pFileName, 1, length(pFileName)-1), xlExcel7,);
    //vWorkbook.Application.Goto_('MainRange',false);
    //vWorkbook.Application.Sheets.Range[] ('MainRange', 1);
    //vWorkbook.Application.Sheets.Copy();
    }
    {
    vSheet := vWorkbook.Sheets[1] As Excel2000._WorkSheet;
    vRange := vSheet.Range['B8','AE'].Value;
    vRange.Copy;
    vSheet.Range['B2','EX31'].PasteSpecial(xlPasteValues, xlNone, False, True);
    vWorkbook.Sheets[0]:= vSheet;
    vWorkbook.Save(0);
    }

    (*
    Application.Goto Reference:="MainRange"
    Selection.Copy
    Sheets("Ëèñò1").Select
    Range("B3").Select
    Columns("C:C").ColumnWidth = 35.43
    *)

    //vExcelApp.Quit;
  end;


var
  cr : TCursor;
  Report : TFlexCelReport;
  dsRangeAbonent, dsRangeTrafic, dsRangeMOU, dsRangePayment, dsRangeCost, dsRangeARPU : TADODataSet;
  vCurColIndex : integer;
  vCurCOlName : string;
  I: Integer;
  vACCOUNT_LIST : string;
  vACCOUNT_NAME : string;
  TemplateFileName, vEXEPath, vUnloadFileName: string;
begin
  cr := Screen.Cursor;
  Screen.Cursor := crHourGlass;

  Report := TFlexCelReport.Create(true);

  try
    vACCOUNT_LIST := GetSelectedAccountList;
    if (vACCOUNT_LIST = '-1') then
    begin
      MessageDlg('Не выбрано ни одного лицевого счета.'#13#10  , mtInformation , [mbOK], 0);
      Exit;
    end;
  finally
    Screen.Cursor := cr;
  end;

  try
    try
      qReportRecoveryCloseContracts.Close;
      qReportRecoveryCloseContracts.ParamByName('pYEAR_MONTH_BEGIN').Value := dblkcbbPeriodBegin.KeyValue;
      qReportRecoveryCloseContracts.ParamByName('pYEAR_MONTH_END').Value := dblkcbbPeriodEnd.KeyValue;
      qReportRecoveryCloseContracts.ParamByName('pACCOUNT_LIST').Value := vACCOUNT_LIST;
      Report.AddTable('qReportRecoveryCloseContracts', qReportRecoveryCloseContracts);
      qReportRecoveryCloseContracts.Close;

      qLoadedAccountList.Close;
      qLoadedAccountList.ParamByName('pACCOUNT_LIST').Value := vACCOUNT_LIST;
      Report.AddTable('qACCOUNT_LIST', qLoadedAccountList);
      qLoadedAccountList.Close;

      qOTTOK.Close;
      qOTTOK.ParamByName('pYEAR_MONTH_BEGIN').Value := dblkcbbPeriodBegin.KeyValue;
      qOTTOK.ParamByName('pYEAR_MONTH_END').Value := dblkcbbPeriodEnd.KeyValue;
      qOTTOK.ParamByName('pACCOUNT_LIST').Value := vACCOUNT_LIST;
      qOTTOK.Open;
      Report.AddTable('qOTTOK', qOTTOK);
      qOTTOK.Close;

      qCONNECTIONS.Close;
      qCONNECTIONS.ParamByName('pYEAR_MONTH_BEGIN').Value := dblkcbbPeriodBegin.KeyValue;
      qCONNECTIONS.ParamByName('pYEAR_MONTH_END').Value := dblkcbbPeriodEnd.KeyValue;
      qCONNECTIONS.ParamByName('pACCOUNT_LIST').Value := vACCOUNT_LIST;
      qCONNECTIONS.Open;
      Report.AddTable('qCONNECTIONS', qCONNECTIONS);
      qCONNECTIONS.Close;

      Report.SetValue('DateBegin',  qPeriod.FieldByName('MONTH_YEAR_STRING').AsString);
      Report.SetValue('DateEnd',   qPeriod2.FieldByName('MONTH_YEAR_STRING').AsString);

      vEXEPath := ExtractFilePath(Application.ExeName);
      //TemplateFileName := vEXEPath + 'AnalysPhoneBase.xlsx';
      TemplateFileName := vEXEPath + 'AnalysPhoneBase.xlsm';
      if not FileExists(TemplateFileName) then
        Raise Exception.Create('Файл шаблона "'+TemplateFileName+'" не установлен');

      vUnloadFileName := vEXEPath + Get_TemplateName(0); // Генерим имя выгружаемого файла
      Report.Run( TemplateFileName, vUnloadFileName);
      RunMacros(vUnloadFileName);
      ShellExecute(0, 'open', PCHAR(vUnloadFileName), nil, nil, SW_SHOWNORMAL);
    except
      on e: Exception do
      begin
        MessageDlg('Произошла ошибка при выгрузке отчета в Excel.'#13#10 + e.Message, mtError, [mbOK], 0);
      end;
    end;
  finally
    Screen.Cursor := cr;
    Report.Free;

  end;
end;

function TReportRecoveryCloseContractsFrm.GetSelectedAccountList: string;
var
  vSelectCount, I : Integer;
  vACCOUNT_LIST : string;
begin
  // формируем строку с ACCOUNT_ID через запятую
  vSelectCount := 0;
  vACCOUNT_LIST := '';
  for I := 0 to (CLB_Accounts.Count-1) do
  begin
    if CLB_Accounts.Checked[i] = True then
    begin
      vACCOUNT_LIST := vACCOUNT_LIST + inttostr(integer(CLB_Accounts.Items.Objects[i]))+',';
      vSelectCount := +1;
    end;
  end;

  // если выделены все ЛС, то передаем '-1' - аналог NULL
  if (vSelectCount = CLB_Accounts.Count) then
    vACCOUNT_LIST := '-1'
  else
    vACCOUNT_LIST := Copy(vACCOUNT_LIST, 1, Length(vACCOUNT_LIST)-1); // обрезаем последнюю запятую

  result := vACCOUNT_LIST;
end;

procedure TReportRecoveryCloseContractsFrm.btn1Click(Sender: TObject);
var
  i : integer;
begin
  for i := 0 to CLB_Accounts.Items.Count - 1 do
  begin
    CLB_Accounts.Checked[i] := True;
  end;
end;

procedure TReportRecoveryCloseContractsFrm.btn2Click(Sender: TObject);
var
  i : Integer;
begin
    for i := 0 to CLB_Accounts.Items.Count - 1 do
    begin
      CLB_Accounts.Checked[i] := False;
    end;
end;

procedure TReportRecoveryCloseContractsFrm.btRefreshClick(Sender: TObject);
var
  vACCOUNT_LIST :string;
begin
  vACCOUNT_LIST := GetSelectedAccountList;

  qOTTOK.Close;
  qOTTOK.ParamByName('pYEAR_MONTH_BEGIN').Value := dblkcbbPeriodBegin.KeyValue;
  qOTTOK.ParamByName('pYEAR_MONTH_END').Value := dblkcbbPeriodEnd.KeyValue;
  qOTTOK.ParamByName('pACCOUNT_LIST').Value := vACCOUNT_LIST;
  qOTTOK.Open;

  qCONNECTIONS.Close;
  qCONNECTIONS.ParamByName('pYEAR_MONTH_BEGIN').Value := dblkcbbPeriodBegin.KeyValue;
  qCONNECTIONS.ParamByName('pYEAR_MONTH_END').Value := dblkcbbPeriodEnd.KeyValue;
  qCONNECTIONS.ParamByName('pACCOUNT_LIST').Value := vACCOUNT_LIST;
  qCONNECTIONS.Open;
end;

procedure TReportRecoveryCloseContractsFrm.chkAllAccountClick(Sender: TObject);
var
  i : Integer;
begin
    for i := 0 to CLB_Accounts.Items.Count - 1 do
    begin
      CLB_Accounts.Checked[i] := True;
    end;
end;

end.
