unit Main;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Buttons, ExtCtrls, Menus, ComCtrls, ActnList,
  DBAccess, OdacVcl, DB, Ora, ImgList, MemDS, OraTransaction, OraObjects;

type
  TMainForm = class(TForm)
    MainMenu: TMainMenu;
    WindowTileItem: TMenuItem;
    WindowCascadeItem: TMenuItem;
    WindowArrangeItem: TMenuItem;
    HelpContentsItem: TMenuItem;
    HelpSearchItem: TMenuItem;
    HelpHowToUseItem: TMenuItem;
    HelpAboutItem: TMenuItem;
    StatusLine: TStatusBar;
    N1: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N7: TMenuItem;
    N12: TMenuItem;
    ActionList1: TActionList;
    aConnect: TAction;
    OraSession: TOraSession;
    ConnectDialog: TConnectDialog;
    ImageList32: TImageList;
    ImageList24: TImageList;
    aRefUserNames: TAction;
    ImageList16: TImageList;
    qCheckUserPrivileges: TOraQuery;
    aBeelineLoadPayments: TAction;
    aBeelineLoadStatuses: TAction;
    aBeelineLoadCosts: TAction;
    aReportBills: TAction;
    N47: TMenuItem;
    aBeelineLoadBaseStationMsk: TAction;
    aBeelineLoadBaseStationMO: TAction;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    aLoadMonthDetail: TAction;
    qAccounts: TOraQuery;
    qPeriods: TOraQuery;
    opDetail: TOpenDialog;
    pbStatus: TProgressBar;
    lProgrBar: TLabel;
    PanelProgress: TPanel;
    spUpDetlTypes: TOraStoredProc;
    spUpDetPack: TOraStoredProc;
    Transaction: TOraTransaction;
    spDelPeriod: TOraStoredProc;
    spUpDetail: TOraStoredProc;
    spAccountID: TOraStoredProc;
    aRefDetailTypes: TAction;
    N2: TMenuItem;
    qUserRigthsType_EncryptPwd: TOraQuery;
    aReportLoadMonitor: TAction;
    aReportLoadMonitor1: TMenuItem;
    CheckBox1: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure ShowHint(Sender: TObject);
    procedure WindowTile(Sender: TObject);
    procedure WindowCascade(Sender: TObject);
    procedure WindowArrange(Sender: TObject);
    procedure HelpContents(Sender: TObject);
    procedure HelpSearch(Sender: TObject);
    procedure HelpHowToUse(Sender: TObject);
    procedure HelpAbout(Sender: TObject);
    procedure aConnectExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure aRefUserNamesExecute(Sender: TObject);
    procedure OraSessionAfterConnect(Sender: TObject);
    procedure aBeelineLoadPaymentsExecute(Sender: TObject);
    procedure aBeelineLoadStatusesExecute(Sender: TObject);
    procedure aBeelineLoadCostsExecute(Sender: TObject);
    procedure CheckAdminPrivileges;
    procedure aReportBillsExecute(Sender: TObject);
    procedure aReportDilerPaymentsExecute(Sender: TObject);
    procedure aBeelineLoadBaseStationMskExecute(Sender: TObject);
    procedure aBeelineLoadBaseStationMOExecute(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure aRefDetailTypesExecute(Sender: TObject);
    procedure aReportLoadMonitorExecute(Sender: TObject);
  private
    procedure StartProgress(Max: int64; Caption: string);
    procedure ShowProgress(Pos: int64);
    procedure StopProgress;
    procedure DeleteYearMonths(YearMonths: TStringList);
  public
    FConnected : Boolean;
    FAccountNumber: string;
    FAccountID: integer;
    FYearMonth: integer;
    procedure CheckAdminPrivs(var IsAdmin: Boolean);
    function encrypt_password:boolean;
  end;
  TCost = class
  public
    Cost: Currency;
  end;
  TID = class
  public
    ID: integer;
  end;

const VAT=1.18;

var
  MainForm: TMainForm;

implementation

{$r *.dfm}

uses RefUserNames, ContractsRegistration_Utils, BeelineLoadFrm, ReportDilerPaymets,
      CRStrUtils, RefDetailTypes,ChangePassword, ReportLoadMonitor;

function TMainForm.encrypt_password:boolean;
begin
 if (GetConstantValue('SERVER_NAME')='CORP_MOBILE')and
       (GetConstantValue('ENCRYPT_PASSWORD')='1')
 then
   result:=true
 else result:=false
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  Application.OnHint := ShowHint;
end;

procedure TMainForm.ShowHint(Sender: TObject);
begin
  StatusLine.SimpleText := Application.Hint;
end;

procedure TMainForm.WindowTile(Sender: TObject);
begin
  Tile;
end;

procedure TMainForm.WindowCascade(Sender: TObject);
begin
  Cascade;
end;

procedure TMainForm.WindowArrange(Sender: TObject);
begin
  ArrangeIcons;
end;

procedure TMainForm.HelpContents(Sender: TObject);
begin
  Application.HelpCommand(HELP_CONTENTS, 0);
end;

procedure TMainForm.HelpSearch(Sender: TObject);
const
  EmptyString: PChar = '';
begin
  Application.HelpCommand(HELP_PARTIALKEY, Longint(EmptyString));
end;

procedure TMainForm.HelpHowToUse(Sender: TObject);
begin
  Application.HelpCommand(HELP_HELPONHELP, 0);
end;

procedure TMainForm.HelpAbout(Sender: TObject);
begin
  { Add code to show program's About Box }
end;

procedure TMainForm.aBeelineLoadBaseStationMOExecute(Sender: TObject);
var
  f : TBeelineLoadForm;
begin
  CheckAdminPrivileges;
  f := TBeelineLoadBS_MO_Form.Create(Application);
  try
    f.Execute;
  finally
    FreeAndNil(f);
  end
end;

procedure TMainForm.aBeelineLoadBaseStationMskExecute(Sender: TObject);
var
  f : TBeelineLoadForm;
begin
  CheckAdminPrivileges;
  f := TBeelineLoadBS_Msk_Form.Create(Application);
  try
    f.Execute;
  finally
    FreeAndNil(f);
  end
end;

procedure TMainForm.aBeelineLoadCostsExecute(Sender: TObject);
var
  f : TBeelineLoadForm;
begin
  CheckAdminPrivileges;
  f := TBeelineLoadCostsForm.Create(Application);
  try
    f.Execute;
  finally
    FreeAndNil(f);
  end
end;

procedure TMainForm.aBeelineLoadPaymentsExecute(Sender: TObject);
var
  f : TBeelineLoadForm;
begin
  CheckAdminPrivileges;
  f := TBeelineLoadPaymentsForm.Create(Application);
  try
    f.Execute;
  finally
    FreeAndNil(f);
  end
end;

procedure TMainForm.aBeelineLoadStatusesExecute(Sender: TObject);
var
  f : TBeelineLoadForm;
begin
  CheckAdminPrivileges;
  f := TBeelineLoadStatusesForm.Create(Application);
  try
    f.Execute;
  finally
    FreeAndNil(f);
  end
end;

procedure TMainForm.aConnectExecute(Sender: TObject);
begin
  OraSession.Connected := False;
  OraSession.Connected := True;
end;

procedure TMainForm.FormShow(Sender: TObject);
var
changepassword:TChangePasswordForm;
begin
  lProgrBar.Hide;
  pbStatus.Hide;
  try
    if not OraSession.Connected then
      aConnect.Execute();
  except
    on eAbort : exception do
      ;
    on E : EDatabaseError do
      ;
  end;
  if OraSession.Connected then
  begin
    FConnected := True;
    LoadKeyboardLayout('00000419', KLF_ACTIVATE);//рус
    //Если выставлена константа шифрования пароля, предлогаем пользователю сменить пароль на шифрованный
    //у владельца схемы пароль нешифрованный
    if encrypt_password and
       (not SameText(OraSession.Username, OraSession.Schema))    then
      try
        qUserRigthsType_EncryptPwd.ParamByName('USER_NAME').AsString := OraSession.Username;
        qUserRigthsType_EncryptPwd.Open;
        if qUserRigthsType_EncryptPwd.FieldByName('encrypt_pwd').AsInteger <> 1 then
          try
            changepassword:=TChangePasswordForm.Create(application);
            if (changepassword.showmodal = mrCancel) then Close;
          finally
            ChangePassword.free;
          end;
      finally
        qUserRigthsType_EncryptPwd.close;
      end;
    MainForm.aReportBills.Visible:=
      (GetConstantValue('SHOW_BILLS_OPERATOR_AND_CLIENT')='1')
        or (GetConstantValue('SERVER_NAME')='SIM_TRADE');
  end
  else
    Close;
end;

procedure TMainForm.CheckAdminPrivs(var IsAdmin: Boolean);
begin
  if SameText(OraSession.Username, OraSession.Schema) then
    IsAdmin:=true
  else begin
    // Под именем схемы работает администратор!
    qCheckUserPrivileges.ParamByName('USER_NAME').AsString := OraSession.Username;
    qCheckUserPrivileges.Open;
    try
      IsAdmin := not qCheckUserPrivileges.IsEmpty;
    finally
      qCheckUserPrivileges.Close;
    end;
  end;
end;

procedure TMainForm.CheckAdminPrivileges;
var
  IsAdmin : Boolean;
begin
  CheckAdminPrivs(IsAdmin);
  if not IsAdmin then
  begin
    ShowMessage('Это функция доступна только администратору системы!');
    Abort;
  end;
end;

procedure TMainForm.aRefDetailTypesExecute(Sender: TObject);
var RefForm: TRefDetailTypesForm;
begin
  CheckAdminPrivileges;
  Panel1.Hide;
  RefForm:=TRefDetailTypesForm.Create(Application);
  RefForm.FormStyle:=fsMDIChild;
end;

procedure TMainForm.aRefUserNamesExecute(Sender: TObject);
var RefFrm : TRefUserNamesForm;
begin
  CheckAdminPrivileges;
  RefFrm := TRefUserNamesForm.Create(Application);
  RefFrm.FormStyle :=fsMDIChild;
end;

procedure TMainForm.aReportBillsExecute(Sender: TObject);
begin
  DoReportBills('BILL');
end;

procedure TMainForm.aReportDilerPaymentsExecute(Sender: TObject);
begin
  DoReportBills('KOMISSIYA');
end;

procedure TMainForm.aReportLoadMonitorExecute(Sender: TObject);
begin
  DoReportLoadMonitor;
end;

procedure TMainForm.ShowProgress(Pos: int64);
begin
  if pbStatus.Max>Pos then
    pbStatus.Position:=Pos
  else
    pbStatus.Position:=pbStatus.Max;
  Application.ProcessMessages;
end;

procedure TMainForm.StartProgress(Max: int64; Caption: string);
begin
  pbStatus.Show;
  pbStatus.Max:=Max;
  pbStatus.Min:=0;
  pbStatus.Width:=PanelProgress.Width-pbStatus.Left-6;
  lProgrBar.Show;
  lProgrBar.Caption:=Caption;
  Application.ProcessMessages;
end;

procedure TMainForm.StopProgress;
begin
  pbStatus.Max:=0;
  pbStatus.Min:=0;
  pbStatus.Hide;
  lProgrBar.Hide;
  Application.ProcessMessages;
end;

procedure TMainForm.DeleteYearMonths(YearMonths: TStringList);
var i, vRes:integer;
    YearMonthCount: TID;
begin
  for i:=0 to YearMonths.Count-1 do
  begin
    YearMonthCount:=YearMonths.Objects[i] as TID;
    vRes:=MessageDlg('Л/С: '+FAccountNumber+'. Найдено '+
      IntToStr(YearMonthCount.ID)+' записей за период: '+
      copy(YearMonths.Strings[i], 5, 2)+'.'+copy(YearMonths.Strings[i], 1, 4)+
      '. Удалить загруженные ранее данные периода перед добавлением детализации?',
      mtConfirmation, [mbYes, mbNo, mbCancel], 0);
    if mrYes=vRes then
    begin
      spDelPeriod.ParamByName('PACCOUNT_NUMBER').AsString:=FAccountNumber;
      spDelPeriod.ParamByName('PYEAR_MONTH').AsInteger:=
        StrToInt(YearMonths.Strings[i]);
      spDelPeriod.ExecSQL;
    end;
  end;
end;

procedure TMainForm.BitBtn1Click(Sender: TObject);
var FileName, Line, AccountNumber, TempString, DateStr, PhoneNumber,
      TypeCall, TypeConn, CommentCall: string;
    SR: TStreamReader;
    FS: TFileStream;
    i, j, Index, LengthFile: integer;
    Delimiter: char;
    Telo, Comments, YearMonths: TStringList;
    Cost, NewCost: TCost;
    AllSum, CostFloat: Currency;
    NewID: TID;
    CommentsLoad, TeloRead, DetailLoad: boolean;
    ert: TParam;
begin
  Cost:=TCost.Create;
  NewCost:=TCost.Create;
  Comments:=TStringList.Create;
  Comments.Sorted:=true;
  Comments.Duplicates:=dupIgnore;
  Comments.Clear;
  Telo:=TStringList.Create;
  Telo.Sorted:=true;
  Telo.Duplicates:=dupIgnore;
  Telo.Clear;
  YearMonths:=TStringList.Create;
  YearMonths.Sorted:=true;
  YearMonths.Duplicates:=dupIgnore;
  YearMonths.Clear;
  opDetail.Title := Caption;
  Delimiter:=';';
  AllSum:=0;
  if opDetail.Execute then
  begin
    FileName:=opDetail.FileName;
    try
      FS:=TFileStream.Create(FileName, fmOpenRead or fmShareDenyNone);
      StartProgress(FS.Size, 'Чтение:');
      SR:=TStreamReader.Create(FS, TEncoding.Default);
      Line:=SR.ReadLine;
      i:=0;
//Чтение файла
      try
        repeat
          Line:=SR.ReadLine;
          ShowProgress(FS.Position);
          if i<1 then
            FAccountNumber:=GetToKen(Line, 1, Delimiter)
          else
            AccountNumber:=GetToKen(Line, 1, Delimiter);
          if (AccountNumber=FAccountNumber)or(i=0) or (CheckBox1.Checked) then
          begin
            PhoneNumber:=GetToKen(Line, 3, Delimiter);
            TempString:=GetToKen(Line, 4, Delimiter);
            DateStr:=copy(TempString, 7, 4)+copy(TempString, 4, 2);
            if YearMonths.Find(DateStr, Index) then
            begin
              NewID:=YearMonths.Objects[Index] As TID;
              NewID.ID:=NewID.ID+1;
            end
            else
            begin
              NewID:=TID.Create;
              NewID.ID:=1;
              YearMonths.AddObject(DateStr, NewID);
            end;
            TypeCall:=GetToKen(Line, 11, Delimiter);
            CommentCall:=GetToKen(Line, 12, Delimiter);
            TypeConn:=GetToKen(Line, 13, Delimiter);
            if (Length(TypeCall)>=0)and(Length(CommentCall)>0)and(Length(TypeConn)>0) then
            begin
              CostFloat:=StrToFloat(GetToKen(Line, 8, Delimiter))*VAT;
              AllSum:=AllSum+CostFloat;
              TempString:=TypeConn+Delimiter+TypeCall+Delimiter+CommentCall;
              Comments.Append(TempString);
              if Telo.Find(DateStr+Delimiter+PhoneNumber+Delimiter+TempString, Index) then
              begin
                NewCost:=Telo.Objects[Index] As TCost;
                NewCost.Cost:=NewCost.Cost+CostFloat;
              end
              else
              begin
                Cost:=TCost.Create;
                Cost.Cost:=CostFloat;
                Telo.AddObject(DateStr+Delimiter+PhoneNumber+Delimiter+TempString, Cost);
              end;
            end;
          end;
          inc(i);
        until Length(Line)=0;
        LengthFile:=i;
        TeloRead:=true;
      except
        TeloRead:=false;
        DetailLoad:=false;
      end;
      StopProgress;
       if CheckBox1.Checked then FAccountNumber:='473178638';

      if TeloRead then
      begin
//Затирка старых записей
        DeleteYearMonths(YearMonths);
//Загрузка новых описаний
        StartProgress(Comments.Count, 'Обновление описаний:');
        try
          Transaction.StartTransaction;
          for Index:=0 to Comments.Count-1 do
          begin
            ShowProgress(Index);
            TempString:=Comments.Strings[Index];
            spUpDetlTypes.ParamByName('PTYPE_CONNECTION').AsString:=
              GetToKen(Comments.Strings[Index], 1, Delimiter);
            spUpDetlTypes.ParamByName('PTYPE_CALL').AsString:=
              GetToKen(Comments.Strings[Index], 2, Delimiter);
            spUpDetlTypes.ParamByName('PCOMMENT_CALL').AsString:=
              GetToKen(Comments.Strings[Index], 3, Delimiter);
            spUpDetlTypes.ExecSQL;
            NewID:=TID.Create;
            NewID.ID:=spUpDetlTypes.ParamByName('RESULT').AsInteger;
            Comments.Objects[Index]:=NewID;
          end;
          Transaction.Commit;
          CommentsLoad:=true;
        except
          Transaction.Rollback;
          Application.MessageBox(PChar('Ошибка загрузки новых описаний: '+
            TempString), 'Уведомление', MB_OK + MB_ICONINFORMATION);
          CommentsLoad:=false;
          DetailLoad:=false;
        end;
        StopProgress;
//Загрузка новых данных
        if CommentsLoad then
        begin
          StartProgress(Telo.Count, 'Запись в БД:');
          try
            Transaction.StartTransaction;
            spUpDetail.ParamByName('PACCOUNT_NUMBER').AsString:=FAccountNumber;
            Index:=0;
            ShowProgress(Index);
            repeat
              spUpDetail.ParamByName('PYEAR_MONTH').AsInteger:=
                StrToInt(GetToKen(Telo.Strings[Index], 1, Delimiter));
              spUpDetail.ParamByName('PPHONE_NUMBER').AsString:=
                GetToKen(Telo.Strings[Index], 2, Delimiter);
              TempString:=GetToKen(Telo.Strings[Index], 3, Delimiter)+Delimiter+
                          GetToKen(Telo.Strings[Index], 4, Delimiter)+Delimiter+
                          GetToKen(Telo.Strings[Index], 5, Delimiter);
              Comments.Find(TempString, j);
              NewID:=Comments.Objects[j] as TID;
              spUpDetail.ParamByName('PDETAIL_TYPE_ID').AsInteger:=
                NewID.ID;
              NewCost:=Telo.Objects[Index] as TCost;
              spUpDetail.ParamByName('PCOST').AsFloat:=
                NewCost.Cost;
              spUpDetail.ExecSQL;
              TempString:=spUpDetail.ParamByName('RESULT').AsString;
              Inc(Index);
              ShowProgress(Index);
            until Index>=Telo.Count;
            Transaction.Commit;
            StopProgress;
            DetailLoad:=True;
          except
            Transaction.Rollback;
            Application.MessageBox(PChar('Ошибка загрузки статистики детализации'),
              'Уведомление', MB_OK + MB_ICONINFORMATION);
            DetailLoad:=false;
          end;
        end;
      end;
      if DetailLoad then
        Application.MessageBox(PChar('Детализация успешно загружена'),
          'Уведомление', MB_OK + MB_ICONINFORMATION);
    finally
      for I:=0 to Telo.Count-1 do
        Telo.Objects[I].Free;
      Telo.Free;
      for I:=0 to Comments.Count-1 do
        Comments.Objects[I].Free;
      Comments.Free;
    end;
  end;
end;

{   Кусок кода для записи данных пакетами, НЕОТЛАЖЕН.
            repeat
              for i:=1 to 10 do
                if Index<Telo.Count then
                begin
                  if i=1 then
                    spUpDetPack.ParamByName('PYEAR_MONTH_PACKAGE').AsString:=
                      GetToKen(Telo.Strings[Index], 1, Delimiter)
                  else
                    spUpDetPack.ParamByName('PYEAR_MONTH_PACKAGE').AsString:=
                      spUpDetPack.ParamByName('PYEAR_MONTH_PACKAGE').AsString+
                      Delimiter+GetToKen(Telo.Strings[Index], 1, Delimiter);
                  if i=1 then
                    spUpDetPack.ParamByName('PPHONE_NUMBER_PACKAGE').AsString:=
                      GetToKen(Telo.Strings[Index], 2, Delimiter)
                  else
                    spUpDetPack.ParamByName('PPHONE_NUMBER_PACKAGE').AsString:=
                      spUpDetPack.ParamByName('PPHONE_NUMBER_PACKAGE').AsString+
                      Delimiter+GetToKen(Telo.Strings[Index], 2, Delimiter);
                  TempString:=GetToKen(Telo.Strings[Index], 3, Delimiter)+Delimiter+
                              GetToKen(Telo.Strings[Index], 4, Delimiter)+Delimiter+
                              GetToKen(Telo.Strings[Index], 5, Delimiter);
                  Comments.Find(TempString, j);
                  NewID:=Comments.Objects[j] as TID;
                  if i=1 then
                    spUpDetPack.ParamByName('PDETAIL_TYPE_ID_PACKAGE').AsString:=
                      IntToStr(NewID.ID)
                  else
                    spUpDetPack.ParamByName('PDETAIL_TYPE_ID_PACKAGE').AsString:=
                      spUpDetPack.ParamByName('PDETAIL_TYPE_ID_PACKAGE').AsString+
                      Delimiter+IntToStr(NewID.ID);
                  NewCost:=Telo.Objects[Index] as TCost;
                  if i=1 then
                    spUpDetPack.ParamByName('PCOST_PACKAGE').AsString:=
                      FloatToStr(NewCost.Cost)
                  else
                    spUpDetPack.ParamByName('PCOST_PACKAGE').AsString:=
                      spUpDetPack.ParamByName('PCOST_PACKAGE').AsString+
                      Delimiter+FloatToStr(NewCost.Cost);
                  Inc(Index);
                  ShowProgress(Index);
                end;
              spUpDetPack.ExecSQL;
            until Index>=Telo.Count;  }

function GetVersionTextOfModule(const FileName : string) : string;
{$IFNDEF CLR}
var
  V1, V2, V3, V4 : Word;
  VerInfoSize : Cardinal;
  VerInfo : Pointer;
  VerValueSize : Cardinal;
  VerValue : PVSFixedFileInfo;
  Dummy : Cardinal;
{$ELSE}
var
  FileVersionAttribute : AssemblyFileVersionAttribute;
{$ENDIF}
begin
{$IFNDEF CLR}
  Result := '';
  VerInfoSize := GetFileVersionInfoSize(
    PChar(FileName),
    Dummy);
  if VerInfoSize > 0 then
  begin
    GetMem(VerInfo, VerInfoSize);
    try
      try
        GetFileVersionInfo(PChar(FileName), 0, VerInfoSize, VerInfo);
        VerQueryValue(VerInfo, '\', Pointer(VerValue), VerValueSize);
        with VerValue^ do
        begin
          V1 := dwFileVersionMS shr 16;
          V2 := dwFileVersionMS and $FFFF;
          V3 := dwFileVersionLS shr 16;
          V4 := dwFileVersionLS and $FFFF;
        end;
        Result := IntToStr(v1)+'.'+IntToStr(v2)+'.'+IntToStr(v3)+'.'+IntToStr(v4);
      except
      end;
    finally
      FreeMem(VerInfo, VerInfoSize);
    end;
  end;
{$ELSE}
  FileVersionAttribute := AssemblyFileVersionAttribute(
    AssemblyFileVersionAttribute.GetCustomAttribute(
			&Assembly.GetExecutingAssembly(),
      typeof(AssemblyFileVersionAttribute)
      )
    );
  if FileVersionAttribute = nil then
    Result := '0.0.0.0'
  else
    Result := FileVersionAttribute.Version;
{$ENDIF}
end;

procedure TMainForm.OraSessionAfterConnect(Sender: TObject);
begin
  Caption := 'Тарифер - Учет абонентов ' + GetVersionTextOfModule(ParamStr(0)) + ' - '
    + OraSession.Username;
end;

end.

