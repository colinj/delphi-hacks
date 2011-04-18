unit dmController;

interface

uses
  SysUtils, Classes, uNotification, uModel, uEvents;

type
  TdtmController = class(TDataModule)
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    FGradeIndex: Integer;
    FPerson: TPerson;
    FGrades: TGradesList;
    function GetAge: string;
    function GetFirstName: string;
    function GetLastName: string;
    procedure SetAge(const Value: string);
    procedure SetFirstName(const Value: string);
    procedure SetLastName(const Value: string);
    function GetCurrent: TGrades;
  public
    procedure Next;
    procedure Prev;
    property FirstName: string read GetFirstName write SetFirstName;
    property LastName: string read GetLastName write SetLastName;
    property Age: string read GetAge write SetAge;
    property Current: TGrades read GetCurrent;
  end;

var
  dtmController: TdtmController;

implementation

{$R *.dfm}

procedure TdtmController.DataModuleCreate(Sender: TObject);
begin
  FPerson := TPerson.Create('Tom', 'Perry', 41);
  FGrades := TGradesList.Create;
  FGrades.Add(TGrades.Create('Tom', 20, 50, 40));
  FGrades.Add(TGrades.Create('Peter', 15, 35, 25));
  FGrades.Add(TGrades.Create('Mary', 30, 60, 90));
  FGrades.Add(TGrades.Create('Jane', 10, 20, 40));
  FGradeIndex := 0;
end;

procedure TdtmController.DataModuleDestroy(Sender: TObject);
begin
  FGrades.Free;
  FPerson.Free;
end;

function TdtmController.GetAge: string;
begin
  Result := IntToStr(FPerson.Age);
end;

function TdtmController.GetCurrent: TGrades;
begin
  Result := FGrades[FGradeIndex];
end;

function TdtmController.GetFirstName: string;
begin
  Result := FPerson.FirstName;
end;

function TdtmController.GetLastName: string;
begin
  Result := FPerson.LastName;
end;

procedure TdtmController.Next;
begin
  if FGradeIndex < FGrades.Count - 1 then
    Inc(FGradeIndex)
  else
    FGradeIndex := 0;

  NC.Publish(Self.Current, TGradeNext);
end;

procedure TdtmController.Prev;
begin
  if FGradeIndex = 0 then
    FGradeIndex := FGrades.Count - 1
  else
    Dec(FGradeIndex);

  NC.Publish(Self.Current, TGradePrev);
end;

procedure TdtmController.SetAge(const Value: string);
begin
  FPerson.Age := StrToInt(Value);
  NC.Publish(Self, TAgeEvent);
end;

procedure TdtmController.SetFirstName(const Value: string);
begin
  FPerson.FirstName := Value;
  NC.Publish(Self, TFirstNameEvent);
end;

procedure TdtmController.SetLastName(const Value: string);
begin
  FPerson.LastName := Value;
  NC.Publish(Self, TLastNameEvent);
end;

end.
