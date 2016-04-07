
//////////////////////////////////////////////////
//  Oracle Data Access Components
//  Copyright © 1998-2001 Core Lab. All right reserved.
//  Ora Parser
//  Created:            22.01.99
//  Last modified:      04.04.00
//////////////////////////////////////////////////

unit IntecOraParser;

interface
uses
  IntecCRParser;

const
  lxAND       = 8;
  lxAS        = lxAND + 1;
  lxBEGIN     = lxAS + 1;
  lxBODY      = lxBEGIN + 1;
  lxBY        = lxBODY + 1;
  lxCREATE    = lxBY + 1;
  lxDECLARE   = lxCREATE + 1;
  lxDELETE    = lxDECLARE + 1;
  lxEND       = lxDELETE + 1;
  lxFOR       = lxEND + 1;
  lxFROM      = lxFOR + 1;
  lxFUNCTION  = lxFROM + 1;
  lxGROUP     = lxFUNCTION + 1;
  lxINSERT    = lxGROUP + 1;
  lxINTO      = lxINSERT + 1;
  lxIS        = lxINTO + 1;
  lxOR        = lxIS + 1;
  lxORDER     = lxOR + 1;
  lxPACKAGE   = lxORDER + 1;
  lxPROCEDURE = lxPACKAGE + 1;
  lxREPLACE   = lxPROCEDURE + 1;
  lxRETURNING = lxREPLACE + 1;
  lxSELECT    = lxRETURNING + 1;
  lxTRIGGER   = lxSELECT + 1;
  lxTYPE      = lxTRIGGER + 1;
  lxUNION     = lxTYPE + 1;
  lxUPDATE    = lxUNION + 1;
  lxWHERE     = lxUPDATE + 1;

  OraSymbolCount = 7;
  OraKeywordCount = 28;

type
  TIntecOraParser = class (TIntecParser)
  protected
    function IsAlpha(Ch: char): boolean; override;
    function IsStringQuote(Ch: char): boolean; override;
    function IsIdentQuote(Ch: char): boolean; override;

  public
    constructor Create(Text: PChar); override;
  end;

implementation

var
  SQLLexems: array [1..OraSymbolCount + OraKeywordCount] of PChar;

{ TOraParser }

constructor TIntecOraParser.Create(Text: PChar);
begin
  inherited Create(Text);

  SymbolCount := OraSymbolCount;
  KeywordCount := OraKeywordCount; 
  ArrLexem := @SQLLexems;
  CommentBegin := '/*';
  CommentEnd := '*/';
  InlineComment := '--';
end;

function TIntecOraParser.IsAlpha(Ch: char): boolean;
begin
  Result := inherited IsAlpha(Ch) or (Ch in ['$','#']);
end;

function TIntecOraParser.IsStringQuote(Ch: char): boolean;
begin
  Result := Ch in [''''];
end;

function TIntecOraParser.IsIdentQuote(Ch: char): boolean;
begin
  Result := Ch in ['"'];
end;

initialization

  SQLLexems[1]         := '*';
  SQLLexems[2]         := '=';
  SQLLexems[3]         := ':';
  SQLLexems[4]         := ',';
  SQLLexems[5]         := '.';
  SQLLexems[6]         := ' :=';
  SQLLexems[7]         := '/';

  SQLLexems[lxSELECT]  := 'SELECT';
  SQLLexems[lxFROM]    := 'FROM';
  SQLLexems[lxWHERE]   := 'WHERE';
  SQLLexems[lxORDER]   := 'ORDER';
  SQLLexems[lxBY]      := 'BY';
  SQLLexems[lxGROUP]   := 'GROUP';
  SQLLexems[lxPROCEDURE] := 'PROCEDURE';
  SQLLexems[lxFUNCTION] := 'FUNCTION';
  SQLLexems[lxPACKAGE] := 'PACKAGE';
  SQLLexems[lxTRIGGER] := 'TRIGGER';
  SQLLexems[lxTYPE]    := 'TYPE';
  SQLLexems[lxUNION]   := 'UNION';
  SQLLexems[lxFOR]     := 'FOR';
  SQLLexems[lxBEGIN]   := 'BEGIN';
  SQLLexems[lxEND]     := 'END';
  SQLLexems[lxDECLARE] := 'DECLARE';
  SQLLexems[lxIS]      := 'IS';
  SQLLexems[lxAS]      := 'AS';
  SQLLexems[lxAND]     := 'AND';
  SQLLexems[lxOR]      := 'OR';
  SQLLexems[lxCREATE]  := 'CREATE';
  SQLLexems[lxREPLACE] := 'REPLACE';
  SQLLexems[lxBODY]    := 'BODY';
  SQLLexems[lxINTO]    := 'INTO';
  SQLLexems[lxUPDATE]  := 'UPDATE';
  SQLLexems[lxDELETE]  := 'DELETE';
  SQLLexems[lxINSERT]  := 'INSERT';
  SQLLexems[lxRETURNING]  := 'RETURNING';
end.
