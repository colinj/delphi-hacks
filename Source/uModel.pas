unit uModel;

interface

uses SysUtils, Generics.Collections, uNotification, uEvents;

type
  ETransaction = class(Exception);

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

  TReportCard = class(TObject)
  private
    FTransactionLevel: Integer;
    FChanged: Boolean;
    FName: string;
    FScoreA: Integer;
    FScoreB: Integer;
    FScoreC: Integer;
    procedure SetScoreA(const Value: Integer);
    procedure SetScoreB(const Value: Integer);
    procedure SetScoreC(const Value: Integer);
    procedure SetName(const Value: string);
    procedure Notify(const anEvent: TEventClass);
  public
    constructor Create(const aName: string); overload;
    constructor Create(const aName: string; const aValueA, aValueB, aValueC: Integer); overload;
    procedure BeginUpdate;
    procedure EndUpdate;
    property Name: string read FName write SetName;
    property ScoreA: Integer read FScoreA write SetScoreA;
    property ScoreB: Integer read FScoreB write SetScoreB;
    property ScoreC: Integer read FScoreC write SetScoreC;
  end;

  TReportCardList = class(TObjectList<TReportCard>);

implementation

{ TPerson }

constructor TPerson.Create(const aFirstName, aLastName: string; const anAge: Integer);
begin
  inherited Create;
  FFirstName := aFirstName;
  FLastName := aLastName;
  FAge := anAge;
end;

{ TReportCard }

procedure TReportCard.BeginUpdate;
begin
  Inc(FTransactionLevel);
end;

constructor TReportCard.Create(const aName: string; const aValueA, aValueB, aValueC: Integer);
begin
  inherited Create;
  FTransactionLevel := 0;
  FChanged := False;
  FName := aName;
  FScoreA := aValueA;
  FScoreB := aValueB;
  FScoreC := aValueC;
//  Notify(TGradeChange);
end;

procedure TReportCard.EndUpdate;
begin
  if FTransactionLevel > 0 then
  begin
    Dec(FTransactionLevel);

    if (FTransactionLevel = 0) and FChanged then
      Notify(TReportCardChange);
  end
  else
    raise ETransaction.Create('You are not in a transaction.');
end;

procedure TReportCard.Notify(const anEvent: TEventClass);
begin
  FChanged := True;
  if FTransactionLevel = 0 then
  begin
    FChanged := False;
    NC.Publish(Self, anEvent);
  end;
end;

constructor TReportCard.Create(const aName: string);
begin
  Create(aName, 0, 0, 0);
end;

procedure TReportCard.SetName(const Value: string);
begin
  if FName <> Value then
  begin
    FName := Value;
    Notify(TReportCardNameChange);
  end;
end;

procedure TReportCard.SetScoreA(const Value: Integer);
begin
  if FScoreA <> Value then
  begin
    FScoreA := Value;
    Notify(TReportCardScoreAChange);
  end;
end;

procedure TReportCard.SetScoreB(const Value: Integer);
begin
  if FScoreB <> Value then
  begin
    FScoreB := Value;
    Notify(TReportCardScoreBChange);
  end;
end;

procedure TReportCard.SetScoreC(const Value: Integer);
begin
  if FScoreC <> Value then
  begin
    FScoreC := Value;
    Notify(TReportCardScoreCChange);
  end;
end;

end.
