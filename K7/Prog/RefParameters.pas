unit RefParameters;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TemplateFrm, Ora, ActnList, Menus, DB, MemDS, DBAccess, Grids,
  DBGrids, CRGrid, ComCtrls, ToolWin, ExtCtrls;

type
  TRefParametersForm = class(TTemplateForm)
    qMainPARAM_ID: TFloatField;
    qMainNAME: TStringField;
    qMainVALUE: TStringField;
    qMainTYPE: TStringField;
    qMainDESCR: TStringField;
    procedure CRDBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TRefParametersForm.CRDBGrid1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if (qMainTYPE.AsString='P') and (datacol=1) then
       With TCRDBGrid(sender).Canvas do
       begin
          if gdSelected in state then Brush.Color:=clHighlight else Brush.Color:= clWhite;
          FillRect(Rect);
          TextOut(Rect.Right-2-TCRDBGrid(sender).Canvas.TextWidth('********'),Rect.Top+2,'********');
       end;
end;

end.
