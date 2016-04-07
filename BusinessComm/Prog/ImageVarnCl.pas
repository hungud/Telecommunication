unit ImageVarnCl;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Vcl.ExtCtrls, Vcl.ComCtrls, Dialogs, Menus, DB, DBCtrls, JPEG;

type
  TImageVarn = class(TImage)
  private
    fTimer: TTimer;
    fBlink: Boolean;
    procedure SetBlink(Value: Boolean);
    procedure MyTimer(Sender: TObject);
  public

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

  published
    property Blink: Boolean read fBlink write SetBlink default false;
  end;

implementation

constructor TImageVarn.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fTimer := TTimer.Create(self);
  fTimer.Enabled := false;
  fTimer.OnTimer := MyTimer;
  fTimer.Interval := 500;
  self.Visible := false;
end;

destructor TImageVarn.Destroy;
begin
  fTimer.Free;
  fTimer := nil;

  inherited Destroy;
end;

procedure TImageVarn.SetBlink(Value: Boolean);
begin
  if Blink <> Value then
  begin
    fBlink := Value;
    fTimer.Enabled := fBlink;
    if not Blink then
      self.Visible := false;
  end;
end;

procedure TImageVarn.MyTimer(Sender: TObject);
begin
  self.Visible := not self.Visible;
end;

end.
