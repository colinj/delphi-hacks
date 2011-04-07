unit dmController;

interface

uses
  SysUtils, Classes, uNotification, uModel;

type
  TDataModule1 = class(TDataModule)
    procedure DataModuleCreate(Sender: TObject);
  private
    FPerson: TPerson;
    function GetAge: string;
    function GetFirstName: string;
    function GetLastName: string;
    procedure SetAge(const Value: string);
    procedure SetFirstName(const Value: string);
    procedure SetLastName(const Value: string);
  public
    property FirstName: string read GetFirstName write SetFirstName;
    property LastName: string read GetLastName write SetLastName;
    property Age: string read GetAge write SetAge;
  end;

var
  DataModule1: TDataModule1;
  NC: TNotificationCentre;

const
  N_CHANGE_FNAME = 1;
  N_CHANGE_LNAME = 2;
  N_CHANGE_AGE = 3;

implementation

{$R *.dfm}

procedure TDataModule1.DataModuleCreate(Sender: TObject);
begin
  FPerson := TPerson.Create('Tom', 'Perry', 41);
end;

function TDataModule1.GetAge: string;
begin
  Result := IntToStr(FPerson.Age);
end;

function TDataModule1.GetFirstName: string;
begin
  Result := FPerson.FirstName;
end;

function TDataModule1.GetLastName: string;
begin
  Result := FPerson.LastName;
end;

procedure TDataModule1.SetAge(const Value: string);
begin
  FPerson.Age := StrToInt(Value);
  NC.Broadcast(Self, N_CHANGE_AGE);
end;

procedure TDataModule1.SetFirstName(const Value: string);
begin
  FPerson.FirstName := Value;
  NC.Broadcast(Self, N_CHANGE_FNAME);
end;

procedure TDataModule1.SetLastName(const Value: string);
begin
  FPerson.LastName := Value;
  NC.Broadcast(Self, N_CHANGE_LNAME);
end;

initialization

  NC := TNotificationCentre.Create;

finalization

  NC.Free;

end.
