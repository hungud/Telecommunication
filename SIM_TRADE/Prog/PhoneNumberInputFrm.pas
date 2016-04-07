unit PhoneNumberInputFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Mask;

type
  TPhoneNumberInputForm = class(TForm)
    eSearch: TMaskEdit;
    BitBtn2: TBitBtn;
    BitBtn1: TBitBtn;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PhoneNumberInputForm: TPhoneNumberInputForm;

implementation

{$R *.dfm}

end.
