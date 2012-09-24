unit uEventAgg;

interface

uses SysUtils, Classes, Generics.Collections;

type
  TEvent = class(TObject);

  TEventClass = class of TEvent;

  TCallbackProc = procedure(const aPublisher: TObject; const anEvent: TEventClass) of object;

  TDispatch = record
  private
    FNotification: TCallbackProc;
    FPublisher: TObject;
  public
    constructor Create(const aNotification: TCallbackProc; const aPublisher: TObject);
    property Handle: TCallbackProc read FNotification write FNotification;
    property Publisher: TObject read FPublisher write FPublisher;
  end;

  TDispatchList = class(TList<TDispatch>);

  TDispatchTable = class(TDictionary<TEventClass, TDispatchList>);

  TEventAggregator = class(TObject)
  strict private
    FDispatchTable: TDispatchTable;
    function SameMethod(const aFirst, aSecond: TCallbackProc): Boolean;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Publish(const aPublisher: TObject; const anEvent: TEventClass);
    procedure Subscribe(const aSubscriber: TCallbackProc; const anEvent: TEventClass; const aPublisher: TObject = nil);
    procedure Unsubscribe(const aSubscriber: TCallbackProc); overload;
    procedure Unsubscribe(const aSubscriber: TCallbackProc; const anEvent: TEventClass; const aPublisher: TObject = nil); overload;
  end;


implementation

{ TEventAggregator }

procedure TEventAggregator.Subscribe(const aSubscriber: TCallbackProc; const anEvent: TEventClass; const aPublisher: TObject);
var
  DispatchList: TDispatchList;
  DispatchItem: TDispatch;
begin
  DispatchItem := TDispatch.Create(aSubscriber, aPublisher);

  if not FDispatchTable.TryGetValue(anEvent, DispatchList) then
  begin
    DispatchList := TDispatchList.Create;
    FDispatchTable.Add(anEvent, DispatchList);
  end;

  if DispatchList.IndexOf(DispatchItem) < 0 then
    DispatchList.Add(DispatchItem);
end;

constructor TEventAggregator.Create;
begin
  inherited;
  FDispatchTable := TDispatchTable.Create;
end;

destructor TEventAggregator.Destroy;
var
  DispatchList: TDispatchList;
begin
  for DispatchList in FDispatchTable.Values do
    DispatchList.Free;

  FDispatchTable.Free;
  inherited;
end;

procedure TEventAggregator.Publish(const aPublisher: TObject; const anEvent: TEventClass);
var
  Dispatcher: TDispatchList;
  Dispatch: TDispatch;
  Event: TEventClass;
begin
  for Event in FDispatchTable.Keys do
    if anEvent.InheritsFrom(Event) then
    begin
      Dispatcher := FDispatchTable.Items[Event];
      for Dispatch in Dispatcher do
        if (Dispatch.Publisher = nil) or (Dispatch.Publisher = aPublisher) then
          Dispatch.Handle(aPublisher, anEvent);
    end;
end;

procedure TEventAggregator.Unsubscribe(const aSubscriber: TCallbackProc);
begin
  Unsubscribe(aSubscriber, nil, nil);
end;

procedure TEventAggregator.Unsubscribe(const aSubscriber: TCallbackProc; const anEvent: TEventClass; const aPublisher: TObject);
var
  DispatchList: TDispatchList;
  I: Integer;
begin
  if Assigned(anEvent) then
  begin
    if FDispatchTable.TryGetValue(anEvent, DispatchList) then
    begin
      for I := DispatchList.Count - 1 downto 0 do
      begin
        if SameMethod(DispatchList[I].Handle, aSubscriber) and  ((aPublisher = nil) or (DispatchList[I].Publisher = aPublisher)) then
          DispatchList.Delete(I);
      end;
    end;
  end
  else
    for DispatchList in FDispatchTable.Values do
    begin
      for I := DispatchList.Count - 1 downto 0 do
      begin
        if SameMethod(DispatchList[I].Handle, aSubscriber) and ((aPublisher = nil) or (DispatchList[I].Publisher = aPublisher)) then
          DispatchList.Delete(I);
      end;
    end;
end;

function TEventAggregator.SameMethod(const aFirst, aSecond: TCallbackProc): Boolean;
begin
  Result := (TMethod(aFirst).Code = TMethod(aSecond).Code) and (TMethod(aFirst).Data = TMethod(aSecond).Data);
end;

{ TDispatch }

constructor TDispatch.Create(const aNotification: TCallbackProc; const aPublisher: TObject);
begin
  FNotification := aNotification;
  FPublisher := aPublisher;
end;

end.
