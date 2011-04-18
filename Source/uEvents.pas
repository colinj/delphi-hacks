unit uEvents;

interface

uses uNotification;

type
  TPersonEvent = class(TEvent);
  TFirstNameEvent = class(TPersonEvent);
  TLastNameEvent = class(TPersonEvent);
  TAgeEvent = class(TPersonEvent);

  TGradeEvent = class(TEvent);
  TGradeNext = class(TGradeEvent);
  TGradePrev = class(TGradeEvent);
  TGradeChange = class(TGradeEvent);
  TGradeNameChange = class(TGradeChange);
  TGradeValAChange = class(TGradeChange);
  TGradeValBChange = class(TGradeChange);
  TGradeValCChange = class(TGradeChange);

var
  NC: TNotificationCentre;

implementation


initialization

  NC := TNotificationCentre.Create;

finalization

  NC.Free;

end.
