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

  TNotificationProc = procedure(const aNotification: TNotification) of object;

  TDispatch = record
  private
    FNotification: TNotificationProc;
    FSubject: TObject;
  public
    constructor Create(const aNotification: TNotificationProc; const aSubject: TObject);
    property Notification: TNotificationProc read FNotification write FNotification;
    property Subject: TObject read FSubject write FSubject;
  end;

  TDispatchList = class(TList<TDispatch>);

  TDispatchTable = class(TDictionary<Integer, TDispatchList>);

  TNotificationCentre = class(TObject)
  strict private
    FDispatchTable: TDispatchTable;
  public
    constructor Create;
    destructor Destroy; override;
    procedure AddObserver(const aReceive: TNotificationProc; const anId: Integer; const aSubject: TObject = nil);
    procedure Notify(const aNotification: TNotification);
    procedure NotifyWith(const anId: Integer; const aSubject: TObject = nil);
    procedure RemoveObserver(const anObserver: TObject); overload;
    procedure RemoveObserver(const anObserver: TObject; const anId: Integer; const aSubject: TObject); overload;
  end;


implementation

{ TNotificationCentre }

procedure TNotificationCentre.AddObserver(const aReceive: TNotificationProc; const anId: Integer; const aSubject: TObject);
var
  DispatchList: TDispatchList;
  DispatchItem: TDispatch;
begin
  DispatchItem := TDispatch.Create(aReceive, aSubject);

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

procedure TNotificationCentre.Notify(const aNotification: TNotification);
var
  DispatchList: TDispatchList;
  DispatchItem: TDispatch;
begin
  if FDispatchTable.TryGetValue(aNotification.Id, DispatchList) then
  begin
    for DispatchItem in DispatchList do
      if (DispatchItem.Subject = nil) or (DispatchItem.Subject = aNotification.Subject) then
        DispatchItem.Notification(aNotification);
  end;

end;

procedure TNotificationCentre.NotifyWith(const anId: Integer; const aSubject: TObject);
var
  Notification: TNotification;
begin
  Notification := TNotification.Create(anId, aSubject);
  try
    Notify(Notification);
  finally
    Notification.Free;
  end;
end;

procedure TNotificationCentre.RemoveObserver(const anObserver: TObject; const anId: Integer; const aSubject: TObject);
var
  DispatchList: TDispatchList;
  I: Integer;
begin
  if anId > 0 then
    if FDispatchTable.TryGetValue(anId, DispatchList) then
    begin
      for I := DispatchList.Count - 1 downto 0 do
      begin
        if (TMethod(DispatchList[I].Notification).Data = anObserver) and 
          ((aSubject = nil) or (DispatchList[I].Subject = aSubject)) then
          DispatchList.Delete(I);
      end;
    end
  else
    for DispatchList in FDispatchTable.Values do
    begin
      for I := DispatchList.Count - 1 downto 0 do
      begin
        if (TMethod(DispatchList[I].Notification).Data = anObserver) and 
          ((aSubject = nil) or (DispatchList[I].Subject = aSubject)) then
          DispatchList.Delete(I);
      end;
    end;
end;

procedure TNotificationCentre.RemoveObserver(const anObserver: TObject);
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
