unit dmController;

interface

uses
  SysUtils, Classes, uEventAgg, uModel, uEvents;

type
  TdtmController = class(TDataModule)
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    FItemIndex: Integer;
    FReportCards: TReportCardList;
    function GetCurrent: TReportCard;
    procedure SetItemIndex(const Value: Integer);
  public
    procedure Next;
    procedure Prev;
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
end;

function TdtmController.GetCurrent: TReportCard;
begin
  Result := FReportCards[FItemIndex];
end;

procedure TdtmController.Next;
begin
  if FItemIndex < FReportCards.Count - 1 then
    ItemIndex := FItemIndex + 1
  else
    ItemIndex := 0;
end;

procedure TdtmController.Prev;
begin
  if FItemIndex = 0 then
    ItemIndex := FReportCards.Count - 1
  else
    ItemIndex := FItemIndex - 1;

  EA.Publish(Self.Current, TReportCardPrev);
end;

procedure TdtmController.SetItemIndex(const Value: Integer);
begin
  if FItemIndex <> Value then
  begin
    FItemIndex := Value;
    EA.Publish(Self.Current, TReportCardNav);
  end;
end;

end.
