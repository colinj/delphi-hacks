unit dmController;

interface

uses
  SysUtils, Classes, uNotification, uModel, uEvents;

type
  TdtmController = class(TDataModule)
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    FItemIndex: Integer;
    FPerson: TPerson;
    FReportCards: TReportCardList;
    function GetAge: string;
    function GetFirstName: string;
    function GetLastName: string;
    procedure SetAge(const Value: string);
    procedure SetFirstName(const Value: string);
    procedure SetLastName(const Value: string);
    function GetCurrent: TReportCard;
    procedure SetItemIndex(const Value: Integer);
  public
    procedure Next;
    procedure Prev;
    property FirstName: string read GetFirstName write SetFirstName;
    property LastName: string read GetLastName write SetLastName;
    property Age: string read GetAge write SetAge;
    property Current: TReportCard read GetCurrent;
    property ReportCards: TReportCardList read FReportCards;
    property ItemIndex: Integer read FItemIndex write SetItemIndex;
  end;

var
  dtmController: TdtmController;

implementation

{$R *.dfm}

procedure TdtmController.DataModuleCreate(Sender: TObject);
begin
  FPerson := TPerson.Create('Tom', 'Perry', 41);
  FReportCards := TReportCardList.Create;
  FReportCards.Add(TReportCard.Create('Tom', 20, 50, 40));
  FReportCards.Add(TReportCard.Create('Peter', 15, 35, 25));
  FReportCards.Add(TReportCard.Create('Mary', 30, 60, 90));
  FReportCards.Add(TReportCard.Create('Jane', 10, 20, 40));
  FItemIndex := 0;
end;

procedure TdtmController.DataModuleDestroy(Sender: TObject);
begin
  FReportCards.Free;
  FPerson.Free;
end;

function TdtmController.GetAge: string;
begin
  Result := IntToStr(FPerson.Age);
end;

function TdtmController.GetCurrent: TReportCard;
begin
  Result := FReportCards[FItemIndex];
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
  if FItemIndex < FReportCards.Count - 1 then
    Inc(FItemIndex)
  else
    FItemIndex := 0;

  NC.Publish(Self.Current, TReportCardNext);
end;

procedure TdtmController.Prev;
begin
  if FItemIndex = 0 then
    FItemIndex := FReportCards.Count - 1
  else
    Dec(FItemIndex);

  NC.Publish(Self.Current, TReportCardPrev);
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

procedure TdtmController.SetItemIndex(const Value: Integer);
begin
  if FItemIndex <> Value then
  begin
    FItemIndex := Value;
    NC.Publish(Self.Current, TReportCardNav);
  end;
end;

procedure TdtmController.SetLastName(const Value: string);
begin
  FPerson.LastName := Value;
  NC.Publish(Self, TLastNameEvent);
end;

end.
