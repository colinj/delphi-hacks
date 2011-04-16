unit uNotification;

interface

uses SysUtils, Classes, Generics.Collections;

type
  TNotificationProc = procedure(const aPublisher: TObject; const aTopic: Integer) of object;

  TDispatch = record
  private
    FNotification: TNotificationProc;
    FPublisher: TObject;
  public
    constructor Create(const aNotification: TNotificationProc; const aSubject: TObject);
    property Handle: TNotificationProc read FNotification write FNotification;
    property Publisher: TObject read FPublisher write FPublisher;
  end;

  TDispatchList = class(TList<TDispatch>);

  TDispatchTable = class(TDictionary<Integer, TDispatchList>);

  TNotificationCentre = class(TObject)
  strict private
    FDispatchTable: TDispatchTable;
    function SameMethod(const aFirst, aSecond: TNotificationProc): Boolean;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Subscribe(const aSubscriber: TNotificationProc; const aTopic: Integer; const aPublisher: TObject = nil);
    procedure Publish(const aPublisher: TObject; const aTopic: Integer);
    procedure Unsubscribe(const aSubscriber: TNotificationProc); overload;
    procedure Unsubscribe(const aSubscriber: TNotificationProc; const anId: Integer; const aPublisher: TObject = nil); overload;
  end;

implementation

{ TNotificationCentre }

procedure TNotificationCentre.Subscribe(const aSubscriber: TNotificationProc; const aTopic: Integer; const aPublisher: TObject);
var
  DispatchList: TDispatchList;
  DispatchItem: TDispatch;
begin
  DispatchItem := TDispatch.Create(aSubscriber, aPublisher);

  if not FDispatchTable.TryGetValue(aTopic, DispatchList) then
  begin
    DispatchList := TDispatchList.Create;
    FDispatchTable.Add(aTopic, DispatchList);
  end;

  if DispatchList.IndexOf(DispatchItem) < 0 then
    DispatchList.Add(DispatchItem);
end;

constructor TNotificationCentre.Create;
begin
  inherited;
  FDispatchTable := TDispatchTable.Create;
end;

destructor TNotificationCentre.Destroy;
var
  DispatchList: TDispatchList;
begin
  for DispatchList in FDispatchTable.Values do
    DispatchList.Free;

  FDispatchTable.Free;
  inherited;
end;

procedure TNotificationCentre.Publish(const aPublisher: TObject; const aTopic: Integer);
var
  Dispatcher: TDispatchList;
  Dispatch: TDispatch;
begin
  if FDispatchTable.TryGetValue(aTopic, Dispatcher) then
  begin
    for Dispatch in Dispatcher do
      if (Dispatch.Publisher = nil) or (Dispatch.Publisher = aPublisher) then
        Dispatch.Handle(aPublisher, aTopic);
  end;
end;

function TNotificationCentre.SameMethod(const aFirst, aSecond: TNotificationProc): Boolean;
begin
  Result := (TMethod(aFirst).Code = TMethod(aSecond).Code) and (TMethod(aFirst).Data = TMethod(aSecond).Data);
end;

procedure TNotificationCentre.Unsubscribe(const aSubscriber: TNotificationProc);
begin
  Unsubscribe(aSubscriber, 0, nil);
end;

procedure TNotificationCentre.Unsubscribe(const aSubscriber: TNotificationProc; const anId: Integer; const aPublisher: TObject);
var
  DispatchList: TDispatchList;
  I: Integer;
begin
  if anId > 0 then
    if FDispatchTable.TryGetValue(anId, DispatchList) then
    begin
      for I := DispatchList.Count - 1 downto 0 do
      begin
        if SameMethod(DispatchList[I].Handle, aSubscriber) and  ((aPublisher = nil) or (DispatchList[I].Publisher = aPublisher)) then
          DispatchList.Delete(I);
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

{ TDispatch }

constructor TDispatch.Create(const aNotification: TNotificationProc; const aSubject: TObject);
begin
  FNotification := aNotification;
  FPublisher := aSubject;
end;

end.
