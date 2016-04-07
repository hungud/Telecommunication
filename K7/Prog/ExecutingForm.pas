{*******************************************************}
{*******************************************************}
{               Юнит для создания и уничтожения форм    }
{*******************************************************}
unit ExecutingForm;

interface

uses Forms, System.SysUtils;

type
  TExecutingForm = class(TForm)
  public
    class procedure ShowReport;
    class procedure ShowAsMDIChild;
  end;

implementation

class procedure TExecutingForm.ShowReport;
var
  AForm: TExecutingForm;
begin
  AForm := Self.Create(nil);
  try
    AForm.ShowModal;
  finally
    FreeAndNil(AForm);
  end;
end;

class procedure TExecutingForm.ShowAsMDIChild;
var
  AForm : TExecutingForm;
begin
  AForm := Self.Create(Application);
  AForm.FormStyle := fsMDIChild;
end;

end.
