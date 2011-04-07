unit uNotification;

interface

uses SysUtils, Classes, Generics.Collections;
type
  TNotification = class(TObject)
  strict private
    FId: Integer;
    FSubject: TObject;
  public
    constructor Create(const anId: Integer; const aSubject: TObject);
    property Id: Integer read FId;
    property Subject: TObject read FSubject;
  end;

  TNotificationProc = procedure(const aSubject: TObject) of object;

  TDispatch = record
  private
    FNotification: TNotificationProc;
    FSubject: TObject;
  public
    constructor Create(const aNotification: TNotificationProc; const aSubject: TObject);
    property Receive: TNotificationProc read FNotification write FNotification;
    property Subject: TObject read FSubject write FSubject;
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
    procedure AddObserver(const anObserver: TNotificationProc; const anId: Integer; const aSubject: TObject = nil);
    procedure Broadcast(const aNotification: TNotification);
    procedure BroadcastWith(const anId: Integer; const aSubject: TObject = nil);
    procedure RemoveObserver(const anObserver: TNotificationProc); overload;
    procedure RemoveObserver(const anObserver: TNotificationProc; const anId: Integer; const aSubject: TObject = nil); overload;
  end;


implementation

{ TNotificationCentre }

procedure TNotificationCentre.AddObserver(const anObserver: TNotificationProc; const anId: Integer; const aSubject: TObject);
var
  DispatchList: TDispatchList;
  DispatchItem: TDispatch;
begin
  DispatchItem := TDispatch.Create(anObserver, aSubject);

  if not FDispatchTable.TryGetValue(anId, DispatchList) then
  begin
    DispatchList := TDispatchList.Create;
    FDispatchTable.Add(anId, DispatchList);
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

procedure TNotificationCentre.Broadcast(const aNotification: TNotification);
var
  DispatchList: TDispatchList;
  DispatchItem: TDispatch;
begin
  if FDispatchTable.TryGetValue(aNotification.Id, DispatchList) then
  begin
    for DispatchItem in DispatchList do
      if (DispatchItem.Subject = nil) or (DispatchItem.Subject = aNotification.Subject) then
        DispatchItem.Receive(aNotification.Subject);
  end;                                                          L

end;

procedure TNotificationCentre.BroadcastWith(const anId: Integer; const aSubject: TObject);
var
  Notification: TNotification;
begin
  Notification := TNotification.Create(anId, aSubject);
  try
    Broadcast(Notification);
  finally
    Notification.Free;
  end;
end;

procedure TNotificationCentre.RemoveObserver(const anObserver: TNotificationProc; const anId: Integer; const aSubject: TObject);
var
  DispatchList: TDispatchList;
  I: Integer;
begin
  if anId > 0 then
    if FDispatchTable.TryGetValue(anId, DispatchList) then
    begin
      for I := DispatchList.Count - 1 downto 0 do
      begin
        if SameMethod(DispatchList[I].Receive, anObserver) and
          ((aSubject = nil) or (DispatchList[I].Subject = aSubject)) then
          DispatchList.Delete(I);
      end;
    end
  else
    for DispatchList in FDispatchTable.Values do
    begin
      for I := DispatchList.Count - 1 downto 0 do
      begin
        if SameMethod(DispatchList[I].Receive, anObserver) and
          ((aSubject = nil) or (DispatchList[I].Subject = aSubject)) then
          DispatchList.Delete(I);
      end;
    end;
end;

function TNotificationCentre.SameMethod(const aFirst, aSecond: TNotificationProc): Boolean;
begin
  Result := (TMethod(aFirst).Code = TMethod(aSecond).Code) and (TMethod(aFirst).Data = TMethod(aSecond).Data);
end;

procedure TNotificationCentre.RemoveObserver(const anObserver: TNotificationProc);
begin
  RemoveObserver(anObserver, 0, nil);
end;

{ TDispatch }

constructor TDispatch.Create(const aNotification: TNotificationProc; const aSubject: TObject);
begin
  FNotification := aNotification;
  FSubject := aSubject;
end;

{ TNotification }

constructor TNotification.Create(const anId: Integer; const aSubject: TObject);
begin
  inherited Create;
  FId := anId;
  FSubject := aSubject;
end;

end.
