unit MonitorServices;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Ora,Buttons, Vcl.Grids,
  sSkinManager, Vcl.StdCtrls, sButton, sSpeedButton, sBitBtn,
  Vcl.RibbonLunaStyleActnCtrls, Vcl.Ribbon, sPanel, sGroupBox;

type
  TMonitorServ = class(TForm)
    Panel1: TPanel;
    TimerMonitor: TTimer;
    sSkinManager1: TsSkinManager;
    SBtnGreen: TsSpeedButton;
    SBtnRed: TsSpeedButton;
    SGM: TStringGrid;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure SGMDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect;
      State: TGridDrawState);
    procedure TimerMonitorTimer(Sender: TObject);
    procedure FormResize(Sender: TObject);


  private
    { Private declarations }



  public
    { Public declarations }
     procedure Monitor1;
  end;

var
  MonitorServ: TMonitorServ;
  Panel, PanelMonitor : TPanel;          //19610



implementation

{$R *.dfm}


uses Main;

          procedure TMonitorServ.Monitor1;
          var
 SqlOra : TOraQuery;
 I, j, n, l, k, ii, jj, cc : integer;
 vPanelCount, vPanelTop, vPanelHeight, vBtnHeight, vServerCount, vServiceCount, vServiceCountOut : Integer;
 vServerName, vSvrAdr,vSvrName,sql_collector, SGMColor : String;
 Panel11 : TPanel;
 BoxGr1,BoxGr12 : TsGroupBox;
 BtnServices : TsBitBtn;
 SGMColCount :Boolean;
          begin

    try
 if Assigned(Panel11) then FreeAndNil(Panel11);
 except
   end;

          try
    SqlOra:=TOraQuery.Create(nil);
        with SqlOra do begin
        sql.Text:='select  MS_PARAMS.GET_PARAM_VALUE('+QuotedStr('ROBOT_SITE_ADRESS')+') as ServerName,'+
        'LENGTH(MS_PARAMS.GET_PARAM_VALUE('+QuotedStr('ROBOT_SITE_ADRESS')+'))-LENGTH(REPLACE(MS_PARAMS.GET_PARAM_VALUE('+QuotedStr('ROBOT_SITE_ADRESS')+'),'+QuotedStr(';')+')) as  ServerCount from dual';
       Execute;
        vServerCount:=FieldByName('ServerCount').AsInteger;
        vServerName:=FieldByName('ServerName').AsString;
        end;
    finally
      SqlOra:=nil;
end;
    vSvrName:=vServerName;
try
    SqlOra:=TOraQuery.Create(nil);
        with SqlOra do begin
        sql.Text:='select sum(case when nvl(l.report_type,-1)=-1 then 1 else 0 end) as ServiceCountOut,'+
                  'sum(case when (nvl(l.report_type,-1)<>-1 and nvl(l.is_collector,-1)<>-1) then 1 else 0 end) as ServiceCount'+
                  ' from log_spr_work_service l ';
        Execute;
        vServiceCount:=FieldByName('ServiceCount').AsInteger;
        vServiceCountOut:=FieldByName('ServiceCountOut').AsInteger;
        end;
    finally
      SqlOra:=nil;
end;

Panel1.ParentBackground:=false;
Panel1.ParentColor:=false;
vPanelTop:=0;

Panel11:=TPanel.Create(Owner);
Panel11.Parent:=Panel1;
Panel11.Align:=alClient;

    for i := 1 to 2 do begin

       BoxGr1 :=TsGroupBox.Create(Owner);
       BoxGr1.Parent:=Panel11;
       BoxGr1.ParentColor:=false;
       BoxGr1.ParentBackground:=false;
       if i=1 then begin
       BoxGr1.Caption:='Предоплатный ';
       sql_collector:=' and nvl(l.IS_COLLECTOR,-1)=-1';
            end
       else begin BoxGr1.Caption:='Коллекторский ';
       sql_collector:=' and nvl(l.IS_COLLECTOR,-1)<>-1';
       end;
       BoxGr1.Align:=alTop;
       BoxGr1.Height:=round(Panel1.Height/8.9);
       vPanelTop:=vPanelTop+BoxGr1.Height;
       BoxGr1.Color:=clYellow;
       BoxGr1.Font.Style:=[fsBold];
       BoxGr1.CaptionLayout:=clTopCenter;
       vSvrName:=vServerName;
       for j := 1 to vServerCount
            do begin
                   // разбираем адреса серверов
  vSvrAdr:=copy(vSvrName, 1, pos(';',vSvrName)-1);
  vSvrName:=StringReplace (vSvrName,vSvrAdr+';','',[rfReplaceAll, rfIgnoreCase]);
          BoxGr12 :=TsGroupBox.Create(Owner);
          BoxGr12.Parent:=BoxGr1;
          BoxGr12.Width:=round(BoxGr1.Width/vServerCount);
          BoxGr12.Caption:='Сервер '+IntToStr(vServerCount-j+1);
          BoxGr12.Align:=alLeft;
          BoxGr12.CaptionLayout:=clTopLeft;
          BoxGr12.Font.Style:=[];

             try  //203
    SqlOra:=TOraQuery.Create(nil);
        with SqlOra do begin   //202
       sql.Text:=' select l.report_type||'' : ''||l.report_type_name as ServiceName,'+
                 ' w.account_id,acc.login, w.server_addres, decode(w.err,0,0,1) as err,w.err_text, w.date_time'+
                 ' from log_spr_work_service l, log_work_service w, '+
                 ' (select ww.log_spr_id, nvl(ww.server_addres,-1) as server_addres,'+
                 ' max(ww.date_time) as date_time from log_work_service ww '+
                 ' group by ww.log_spr_id, nvl(ww.server_addres,-1)) z, accounts acc '+
                 ' where l.log_spr_id=w.log_spr_id '+
                 ' and w.server_addres=z.server_addres '+
                 ' and w.date_time = z.date_time '+sql_collector+
                 ' and w.account_id=acc.account_id '+
                 ' and w.server_addres='''+vSvrAdr+''' order by l.log_spr_id';

        Execute;
        First;
        while not Eof do
          begin   // 201
                 BtnServices:=TsBitBtn.Create(Owner);
                 BtnServices.Parent:=BoxGr12;
                 BtnServices.Width:=round(BoxGr12.Width/vServiceCount);
                 BtnServices.Caption :=FieldByName('ServiceName').AsString;
                 BtnServices.Align:=alLeft;
                 BtnServices.Font.Size:=8;
            if FieldByName('Err').AsInteger=1 then
            BtnServices.Glyph:=SBtnRed.Glyph
            else   BtnServices.Glyph:=SBtnGreen.Glyph ;

            BtnServices.ShowHint:=true;
            BtnServices.Hint:=FieldByName('login').AsString+' : '+FieldByName('err_text').AsString;

               Next;
          end;  //201
        end;   //202

    finally
      SqlOra:=nil;
end;      //203
                end;
    end;
     vPanelHeight:=BoxGr12.Height;
     vBtnHeight:=BtnServices.Height;

     if vServiceCountOut<>0 then begin
      vPanelTop:=vPanelTop+BoxGr1.Height;
    BoxGr1 :=TsGroupBox.Create(Owner);
    BoxGr1.Parent:=Panel11;
    BoxGr1.Align:=alTop;
    BoxGr1.Width:=vBtnHeight;
    BoxGr1.Height:=vPanelHeight;
    BoxGr1.Caption:='API и Старый кабинет';
    BoxGr1.Font.Style:=[fsBold];
    BoxGr1.CaptionLayout:=clTopCenter;

      try  //203
    SqlOra:=TOraQuery.Create(nil);

        with SqlOra do begin   //202
       sql.Text:=' select decode(l.server_type,''OLD_CAB'', ''Старый кабинет'',l.server_type) as ServiceName,'+
                 ' w.account_id, w.server_addres, decode(w.err,0,0,1) as err,w.err_text, w.date_time'+
                 ' from log_spr_work_service l, log_work_service w, '+
                 ' (select ww.log_spr_id, nvl(ww.server_addres,-1) as server_addres,'+
                 ' max(ww.date_time) as date_time from log_work_service ww '+
                 ' group by ww.log_spr_id, nvl(ww.server_addres,-1)) z '+
                 ' where l.log_spr_id=w.log_spr_id '+
                 ' and nvl(w.server_addres,-1)=z.server_addres '+
                 ' and w.date_time = z.date_time '+
                 ' and nvl(l.report_type,-1)= -1 order by l.log_spr_id';

        Execute;
        First;
       while not Eof do

          begin   // 201
                 BtnServices:=TsBitBtn.Create(Owner);
                 BtnServices.Parent:=BoxGr1;
                 BtnServices.Width:=round(BoxGr1.Width/vServiceCount);
                 BtnServices.Caption :=FieldByName('ServiceName').AsString;
                 BtnServices.Font.Size:=8;
           if FieldByName('Err').AsInteger=1 then
            BtnServices.Glyph:=SBtnRed.Glyph
            else   BtnServices.Glyph:=SBtnGreen.Glyph ;
            BtnServices.ShowHint:=true;
            BtnServices.Hint:=FieldByName('err_text').AsString;

                 BtnServices.Align:=alLeft;
                 BtnServices.Font.Style:=[];
                  Next;
          end; //201
                  end;    //202
       finally
      SqlOra:=nil;

   end;
       end;

  SGM.Height:=round(Panel1.Height-vPanelTop+6) ;

 with SGM do
  begin
     Cells[0,0]:='№ п/п';
     Cells[1,0]:='Логин';
     ColWidths[0]:=40;
     ColWidths[1]:=150;
  end;

   try  //203
  SqlOra:=TOraQuery.Create(nil);
        with SqlOra do begin   //202
        sql.Text:=' select ACCOUNT_LOAD_TYPE_ID||'':''||account_load_type_name as n_met_type'+
 ' from account_load_types where ACCOUNT_LOAD_TYPE_ID in ( '+
 ' select to_number(rtrim(substr(n_met,instr(n_met,'','',1,iter.pos)+1,instr(n_met,'','',1,iter.pos+1) - '+
 ' instr(n_met,'','',1,iter.pos)),'','')) n_met '+
 ' from ( select '',''||substr(replace(a.n_method,'';'','',''),1, length(a.n_method)-1)||'','' n_met from ACCOUNTS a where'+
 ' length(a.n_method)=(select max(length(n_method)) from ACCOUNTS)) csv,'+
 ' (select rownum pos from account_load_types) iter'+
 ' where iter.pos <= ((length(csv.n_met)-'+
 ' length(replace(csv.n_met,'','')))/length('',''))-1) ';

        Execute;
        First;
        i:=2;
        while not Eof do
          begin   // 201
          with SGM do
  begin
  SGM.Visible:=true;
  SGM.Cells[i,0] :=SqlOra.FieldByName('n_met_type').AsString;
  i:=i+1;
     end;
       Next;
          end;  //201
          SGM.RowCount:=j+1;
        end;   //202
     finally
      SqlOra:=nil;
end;      //203

 SGM.ColCount:=i;

    with SGM do
    begin
       for ii := 2 to ColCount-1 do begin
  SGM.ColWidths[ii] :=SGM.Canvas.TextWidth(SGM.Cells[ii,0])+5;
  if SGM.ColWidths[ii]<SGM.Canvas.TextWidth('Страрый кабинет') then
    SGM.ColWidths[ii] :=SGM.Canvas.TextWidth('Страрый кабинет');
       end;
      end;

   try  //203
    SqlOra:=TOraQuery.Create(nil);
        with SqlOra do begin   //202
        sql.Text:=' select * from accounts';
        Execute;
        First;
        i:=0;
        J:=0;
        while not Eof do
          begin   // 201
          j:=j+1;
          with SGM do
  begin
   SGM.RowCount:= SGM.RowCount+j; //Увеличиваем количество строк на 1
   SGM.Cells[i,j] :=inttostr(j);
   SGM.Cells[i+1,j] :=SqlOra.FieldByName('LOGIN').AsString;
   SGMColor:='';
   SGMColCount:=false;
   SGM.RowHeights[j]:=SGM.Canvas.TextHeight(SGM.Cells[i,j])+2;

       cc:=2;
     while not  SGMColCount do  begin

      SGMColor:= copy(Cells[cc,0], 1, pos(':',Cells[cc,0])-1);

       if pos(SGMColor, SqlOra.FieldByName('N_METHOD').AsString )<>0 then
         Cells[cc,j] :='Новый кабинет'
   else Cells[cc,j] :='Старый кабинет';
         cc:=cc+1;
         if cc=SGM.ColCount then   SGMColCount:=true;

                end;
   end;
       Next;
          end;  //201
          SGM.RowCount:=j+1;
        end;   //202
     finally
      SqlOra:=nil;
end;      //203

          SGM.Visible:=true;

          end;


procedure TMonitorServ.SGMDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
begin
if Pos('Новый кабинет' ,SGM.Cells[ACol,ARow]) > 0 then
 begin SGM.Canvas.Brush.Color:= clGradientActiveCaption;
 SGM.Canvas.Font.Color:=clBlack;

 end;
SGM.Canvas.FillRect(Rect);
SGM.Canvas.TextOut(Rect.Left+2, Rect.Top+2, SGM.Cells[ACol, ARow]);

   if gdSelected in State then
  with Sender as TStringGrid do
    begin

     //Canvas.Brush.Color := clMoneyGreen; clHighLight; clGradientActiveCaption;
     Canvas.Brush.Color:=clTeal;
     Canvas.Font.Color:=clWhite;//clBlack;
     Canvas.FillRect(Rect);
     Canvas.TextOut(rect.Left, rect.Top, Cells[ACol, ARow]);
     end;
end;

procedure TMonitorServ.TimerMonitorTimer(Sender: TObject);
begin
Monitor1;
end;

procedure TMonitorServ.FormActivate(Sender: TObject);
begin

  Monitor1;
  TimerMonitor.Enabled:=true;
end;

procedure TMonitorServ.FormClose(Sender: TObject; var Action: TCloseAction);
begin
TimerMonitor.Enabled:=false;
 MainForm.IsMonitorRun:=false;
 Action:=caFree;
end;

procedure TMonitorServ.FormResize(Sender: TObject);
begin
Monitor1;
end;

end.
