// Модуль используется для формирования динамических хинтов
// (всплывающих подсказок) в приложениях.
//
// Для регистрации динамических обработчиков используется
// функция <LINK RegisterHintEvent@TShowHintEvent@TControl, RegisterHintEvent><LINK RegisterHintEvent@TShowHintEvent@TControl, .>
//
// Для удаления зарегистрированного обработчика из списка
// активных обработчиков используется функция <LINK UnregisterHintEvent@TControl, UnregisterHintEvent><LINK UnregisterHintEvent@TControl, .>
//
// <LINK UnregisterHintEvent@TControl>
unit Hints;
interface
uses Forms, Controls, AppEvnts;

// Регистрирует обработчик хинта для элемента управления.
// 
// Если в элемент управления формирует хинт, то автоматически
// будет вызван зарегистрированный обработчик.
// 
// Вызов функции рекомендуется делать в обработчике события
// формы OnCreate.
// 
// Для отмены регистрации необходимо использовать <LINK UnregisterHintEvent@TControl, UnregisterHintEvent>.
//                                                                                                         
procedure RegisterHintEvent(HintEvent : TShowHintEvent;
  HintControl : TControl);

// Отменяет регистрацию обработчика хинта для элемента
// управления.
// 
// Вызов функции рекомендуется делать в обработчике события
// формы OnDestroy.
// 
// См. также <LINK RegisterHintEvent@TShowHintEvent@TControl, RegisterHintEvent>.
//
procedure UnregisterHintEvent(HintControl : TControl);

implementation

uses Classes;

type

// Структура хранит информацию об обработчике хинта.
THintEventInfo = class
    // Указатель на метод, который является обработчиком события
// всплывающей подсказки.
HintEvent : TShowHintEvent;
    // Ссылка на объект-TControl, для которого зарегистрирован
// обработчик всплывающей подсказки.
HintControl : TControl;
  end;

  // Служебный объект, который хранит список активных обработчиков
  // хинтов.
  //
  // Объект переопределяет обрабочник Application.OnShowHint,
  // поэтому этот обработчик нельзя переопределять где-либо еще в
  // библиотеке.
THintHandler = class
    // Список зарегистрированных обработчиков.
ClientHandlersList : TList;

{ Обработчик событий от приложения }
FApplicationEvents : TApplicationEvents;
    // Конструктор
constructor Create;
    // Деструктор
destructor Destroy; override;

    { Обработчик для Application.OnShowHint.
      
      
      
      Содержит поиск и вызов зарегистрированного обработчика для
      визуального объекта, на котором возникает всплывающая
      подсказка.
      
      
      
      Если обработчик не обнаружен, то вызывается предыдущий
      обработчик Application.OnShowHint (если он есть).          }
procedure ShowHintHandler(var HintStr : string;
      var CanShow : Boolean;
      var HintInfo : THintInfo);
    // Функция возвращает обработчик всплывающей подсказки для
// визуального объекта.
// 
// 
// 
// Если объект не найден, то функция возвращает <B>nil</B>.
function FindHandler(HintControl : TControl) : THintEventInfo;
  end;

var
  { Переменная, которая содержит ссылку на объект, обрабатывающий
  события всплывающей подсказки.                                }
HintHandler : THintHandler;

constructor THintHandler.Create;
begin
  inherited Create;
  ClientHandlersList := TList.Create;
  FApplicationEvents := TApplicationEvents.Create(nil);
  FApplicationEvents.OnShowHint := ShowHintHandler;
end;

destructor THintHandler.Destroy;
begin
  ClientHandlersList.Free;
  FApplicationEvents.Free;
  inherited;
end;

procedure THintHandler.ShowHintHandler(var HintStr : string;
  var CanShow : Boolean;
  var HintInfo : THintInfo);
var
  i : integer;
  CurrentHintEventInfo : THintEventInfo;
begin
  for i := 0 to ClientHandlersList.Count - 1 do
  begin
    CurrentHintEventInfo := THintEventInfo(ClientHandlersList[i]);
    if HintInfo.HintControl = CurrentHintEventInfo.HintControl then
    begin
      begin
        CurrentHintEventInfo.HintEvent(HintStr, CanShow, HintInfo);
        // Отменяем дальнейшую обработку
        FApplicationEvents.CancelDispatch;
        Break;
      end;
    end;
  end;
end;

function THintHandler.FindHandler(HintControl : TControl) : THintEventInfo;
var
  CurrentHintEventInfo : THintEventInfo;
  i : integer;
begin
  Result := nil;
  for i := 0 to ClientHandlersList.Count - 1 do
  begin
    CurrentHintEventInfo := THintEventInfo(ClientHandlersList[i]);
    if CurrentHintEventInfo.HintControl = HintControl then
    begin
      Result := CurrentHintEventInfo;
      Break;
    end;
  end;
end;

procedure RegisterHintEvent(HintEvent : TShowHintEvent;
  HintControl : TControl);
var
  HintEventInfo : THintEventInfo;
begin
  if Assigned(HintHandler) then
  begin
    HintEventInfo := HintHandler.FindHandler(HintControl);
    if HintEventInfo = nil then
    begin
      HintEventInfo := THintEventInfo.Create;
      HintEventInfo.HintControl := HintControl;
      HintHandler.ClientHandlersList.Add(HintEventInfo);
    end;
    HintEventInfo.HintEvent := HintEvent;
  end;
end;

procedure UnregisterHintEvent(HintControl : TControl);
var
  HintEventInfo : THintEventInfo;
begin
  if Assigned(HintHandler) then
  begin
    HintEventInfo := HintHandler.FindHandler(HintControl);
    if HintEventInfo <> nil then
    begin
      HintHandler.ClientHandlersList.Delete(
        HintHandler.ClientHandlersList.IndexOf(HintEventInfo));
      HintEventInfo.Free;
    end;
  end;
end;

initialization
  HintHandler := THintHandler.Create;
finalization
  HintHandler.Free;
  HintHandler := nil;
end.

