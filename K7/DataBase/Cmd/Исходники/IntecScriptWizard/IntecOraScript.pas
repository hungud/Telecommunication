
//////////////////////////////////////////////////
//  Oracle Data Access Components
//  Copyright © 1998-2001 Core Lab. All right reserved.
//  Ora Script
//  Created:            28.06.99
//  Last modified:      11.06.01
//////////////////////////////////////////////////

{ $I Odac.inc}

unit IntecOraScript;

interface

uses
  Classes, SysUtils, ADOInt, ADODB, IntecOraParser{, DBAccess, Ora, CRParser, OraParser};

type
{ TIntecOraScript }

  TBeforeExecuteEvent = procedure (Sender: TObject; var SQL: string; var Omit: boolean) of object;
  TAfterExecuteEvent = procedure (Sender: TObject; SQL: string) of object;
  TErrorAction = (eaAbort, eaFail, eaException, eaContinue);
  TOnErrorEvent = procedure (Sender: TObject; E: Exception; SQL: string; var Action: TErrorAction) of object;

  TIntecOraScript = class (TComponent)
  private
    FSQL: TStrings;
    FOraSQL: TAdoCommand;
    FErrorOffset: integer;
    FStartPos: integer;
    FEndPos: integer;
    FStartLine: integer;
    FEndLine: integer;
    FBeforeExecute: TBeforeExecuteEvent;
    FAfterExecute: TAfterExecuteEvent;
    FOnError: TOnErrorEvent;
    FParser: TIntecOraParser;
    FStmtOffset: integer;
    FScriptSQL: string;

    procedure SetSQL(Value: TStrings);
    procedure SQLChanged(Sender: TObject);
    function GetConnection: TAdoConnection;
    procedure SetConnection(const Value: TAdoConnection);

  protected
    FDesignCreate: boolean;

    procedure Loaded; override;

    procedure AssignTo(Dest: TPersistent); override;

  public
    constructor Create(Owner: TComponent); override;
    destructor Destroy; override;

    procedure Execute;
    function ExecuteNext: boolean;
    procedure BreakExec;

    function ErrorOffset: integer;

    property StartPos: integer read FStartPos write FStartPos;
    property EndPos: integer read FEndPos write FEndPos;
    property StartLine: integer read FStartLine write FStartLine;
    property EndLine: integer read FEndLine write FEndLine;

  published
    property SQL: TStrings read FSQL write SetSQL;
    property Connection : TAdoConnection read GetConnection write SetConnection;

    property BeforeExecute: TBeforeExecuteEvent read FBeforeExecute write FBeforeExecute;
    property AfterExecute:TAfterExecuteEvent read FAfterExecute write FAfterExecute;
    property OnError: TOnErrorEvent read FOnError write FOnError;
  end;

implementation

uses
  Forms, IntecCRParser;

{ TIntecOraScript }

constructor TIntecOraScript.Create(Owner: TComponent);
begin
  inherited;

  FSQL := TStringList.Create;
  TStringList(SQL).OnChange := SQLChanged;
  FOraSQL := TAdoCommand.Create(nil);
  FOraSQL.ParamCheck := False;
  FOnError := nil;
  FErrorOffset := 0;

  FDesignCreate := csDesigning in ComponentState;
end;

destructor TIntecOraScript.Destroy;
begin
  FParser.Free;
  FOraSQL.Free;
  FSQL.Free;

  inherited;
end;

procedure TIntecOraScript.Loaded;
begin
  inherited;

  FDesignCreate:= False;
end;

procedure TIntecOraScript.Execute;
begin
  while ExecuteNext do;
end;

function TIntecOraScript.ErrorOffset:integer;
begin
  Result := FErrorOffset;
end;

procedure TIntecOraScript.AssignTo(Dest: TPersistent);
begin
  if Dest is TIntecOraScript then begin
    TIntecOraScript(Dest).SQL.Text := SQL.Text;
    TIntecOraScript(Dest).Connection := Connection;
  end
  else
    inherited;
end;

procedure TIntecOraScript.SetSQL(Value: TStrings);
begin
 if FSQL.Text <> Value.Text then begin
    FSQL.BeginUpdate;
    try
      FSQL.Assign(Value);
    finally
      FSQL.EndUpdate;
    end;
  end;
end;

procedure TIntecOraScript.SQLChanged(Sender: TObject);
begin
  BreakExec;
end;

function TIntecOraScript.ExecuteNext: boolean;
var
  SQL,St: string;
  Code: integer;
  PrevCode: integer;
  InPLSQL: boolean;
  Action: TErrorAction;
  i: integer;
  Omit: boolean;
begin
  Result := False;
  if FParser = nil then begin
    FScriptSQL := TrimRight(FSQL.Text);
    FParser := TIntecOraParser.Create(PChar(FScriptSQL));
    FParser.OmitBlank := False;
    FParser.Uppered := False;
  end;

  SQL := '';
  InPLSQL := False;
  FErrorOffset := 0;
  Code := 0;
  PrevCode := 0;
  FStartPos := FParser.CurrPos;
  FStartLine := FParser.CurrLine;

  repeat
    if (Code <> lcBlank) and (Code <> lcComment) then
      PrevCode := Code;
    Code := FParser.GetNext(St);

    if ((Code = lcEnd) or ((St = ';') and not (InPLSQL or (Code = lcString)))
      or ((St = '/') and (FParser.PrevCol = 0))) and (Trim(SQL) <> '')
    then
    begin
    // Execution
      FEndPos := FParser.PrevPos;
      FEndLine := FParser.PrevLine;

      Omit := False;
      if Assigned(FBeforeExecute) then
        FBeforeExecute(Self, SQL, Omit);

      if not Omit then
      begin
        FOraSQL.CommandText := SQL;
      end;

      try
        FOraSQL.Execute;

        if Assigned(FAfterExecute) then
          FAfterExecute(Self, SQL);
      except
        on EAbort do
          raise;
        on E: Exception do
        begin
          FErrorOffset := FStmtOffset {+ FOraSQL.ErrorOffset};
          Action := eaException;
          if Assigned(FOnError) then
            FOnError(Self, E, Trim(SQL), Action);
          case Action of
            eaAbort:
              break;
            eaFail:
              raise;
            eaException:
              Application.HandleException(E);
          end;
        end;
      end;
      FStmtOffset := FParser.CurrPos;
      FStartPos := FParser.CurrPos;
      FStartLine := FParser.CurrLine;
      Result := True;
      break;
    end
    else begin
      if (Code in [lxBEGIN, lxDECLARE])
        or ((Code in [lxPROCEDURE, lxFUNCTION, lxPACKAGE])
        and (PrevCode in [lxCREATE, lxREPLACE]))
        or ((Code = lxBODY) and (PrevCode = lxTYPE))
      then
        InPLSQL := True;

      if not((St = '/') and (FParser.PrevCol = 0)) then
        if Code = lcString then
          SQL := SQL + '''' + St + ''''
        else
          if (Code <> lcBlank) or (SQL <> '') then
            SQL := SQL + St
          else
            Inc(FStmtOffset, Length(St));
    end;
  until Code = lcEnd;
  if not Result then begin
    FParser.Free;
    FParser := nil;
  end;
end;

procedure TIntecOraScript.BreakExec;
begin
  FParser.Free;
  FParser := nil;

  FStmtOffset := 0;
  FStartPos := 0;
  FStartLine := 0;
  FEndPos := 0;
  FEndLine := 0;
end;

function TIntecOraScript.GetConnection: TAdoConnection;
begin
  Result := FOraSQL.Connection;
end;

procedure TIntecOraScript.SetConnection(
  const Value: TAdoConnection);
begin
  FOraSQL.Connection := Value;
end;

end.
