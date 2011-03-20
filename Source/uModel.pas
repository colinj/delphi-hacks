unit uModel;

interface

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

implementation

{ TPerson }

constructor TPerson.Create(const aFirstName, aLastName: string; const anAge: Integer);
begin
  inherited Create;
  FFirstName := aFirstName;
  FLastName := aLastName;
  FAge := anAge;
end;

end.
