unit uModel;

interface

uses Generics.Collections, uNotification, uEvents;

type
  TPerson = class(TObject)
  private
    FAge: Integer;
    FLastName: string;
    FFirstName: string;
  public
    constructor Create(const aFirstName, aLastName: string; const anAge: Integer);
    property FirstName: string read FFirstName write FFirstName;
    property LastName: string read FLastName write FLastName;
    property Age: Integer read FAge write FAge;
  end;

  TGrades = class(TObject)
  private
    FTransactionLevel: Integer;
    FChanged: Boolean;
    FName: string;
    FValueA: Integer;
    FValueB: Integer;
    FValueC: Integer;
    procedure SetValueA(const Value: Integer);
    procedure SetValueB(const Value: Integer);
    procedure SetValueC(const Value: Integer);
    procedure SetName(const Value: string);
    procedure Notify(const anEvent: TEventClass);
  public
    constructor Create(const aName: string); overload;
    constructor Create(const aName: string; const aValueA, aValueB, aValueC: Integer); overload;
    procedure BeginUpdate;
    procedure EndUpdate;
    property Name: string read FName write SetName;
    property ValueA: Integer read FValueA write SetValueA;
    property ValueB: Integer read FValueB write SetValueB;
    property ValueC: Integer read FValueC write SetValueC;
  end;

  TGradesList = class(TObjectList<TGrades>);

implementation

{ TPerson }

constructor TPerson.Create(const aFirstName, aLastName: string; const anAge: Integer);
begin
  inherited Create;
  FFirstName := aFirstName;
  FLastName := aLastName;
  FAge := anAge;
end;

{ TGrades }

procedure TGrades.BeginUpdate;
begin
  Inc(FTransactionLevel);
end;

constructor TGrades.Create(const aName: string; const aValueA, aValueB, aValueC: Integer);
begin
  inherited Create;
  FTransactionLevel := 0;
  FChanged := False;
  FName := aName;
  FValueA := aValueA;
  FValueB := aValueB;
  FValueC := aValueC;
//  Notify(TGradeChange);
end;

procedure TGrades.EndUpdate;
begin
  if FTransactionLevel > 0 then
  begin
    Dec(FTransactionLevel);

    if (FTransactionLevel = 0) and FChanged then
      Notify(TGradeChange);
  end
  else
    raise ETransaction.Create('You are not in a transaction.');
end;

procedure TGrades.Notify(const anEvent: TEventClass);
begin
  FChanged := True;
  if FTransactionLevel = 0 then
  begin
    FChanged := False;
    NC.Publish(Self, anEvent);
  end;
end;

constructor TGrades.Create(const aName: string);
begin
  Create(aName, 0, 0, 0);
end;

procedure TGrades.SetName(const Value: string);
begin
  if FName <> Value then
  begin
    FName := Value;
    Notify(TGradeNameChange);
  end;
end;

procedure TGrades.SetValueA(const Value: Integer);
begin
  if FValueA <> Value then
  begin
    FValueA := Value;
    Notify(TGradeValAChange);
  end;
end;

procedure TGrades.SetValueB(const Value: Integer);
begin
  if FValueB <> Value then
  begin
    FValueB := Value;
    Notify(TGradeValBChange);
  end;
end;

procedure TGrades.SetValueC(const Value: Integer);
begin
  if FValueC <> Value then
  begin
    FValueC := Value;
    Notify(TGradeValCChange);
  end;
end;

end.
