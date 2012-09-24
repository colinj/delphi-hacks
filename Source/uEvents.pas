unit uEvents;

interface

uses uEventAgg;

type
  TPersonEvent = class(TEvent);
  TFirstNameEvent = class(TPersonEvent);
  TLastNameEvent = class(TPersonEvent);
  TAgeEvent = class(TPersonEvent);

  TReportCardEvent = class(TEvent);

  TReportCardNav = class(TReportCardEvent);
  TReportCardNext = class(TReportCardNav);
  TReportCardPrev = class(TReportCardNav);

  TReportCardChange = class(TReportCardEvent);
  TReportCardNameChange = class(TReportCardChange);
  TReportCardScoreAChange = class(TReportCardChange);
  TReportCardScoreBChange = class(TReportCardChange);
  TReportCardScoreCChange = class(TReportCardChange);

var
  EA: TEventAggregator;

implementation


initialization

  EA := TEventAggregator.Create;

finalization

  EA.Free;

end.
