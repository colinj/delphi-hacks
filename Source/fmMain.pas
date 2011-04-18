unit fmMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, uNotification, uEvents, TeEngine, Series, ExtCtrls, TeeProcs, Chart;

type
  TfrmMain = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Button1: TButton;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Edit8: TEdit;
    Button2: TButton;
    Button3: TButton;
    Chart1: TChart;
    Series1: TBarSeries;
    Button4: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure Edit3Change(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    procedure UpdateFName(const aPublisher: TObject; const anEvent: TEventClass);
    procedure UpdateLName(const aPublisher: TObject; const anEvent: TEventClass);
    procedure UpdateAge(const aPublisher: TObject; const anEvent: TEventClass);
    procedure UpdateFullName(const aPublisher: TObject; const anEvent: TEventClass);
    procedure UpdateName(const aPublisher: TObject; const anEvent: TEventClass);
    procedure UpdateGrade(const aPublisher: TObject; const anEvent: TEventClass);
    procedure UpdateGradeList(const aPublisher: TObject; const anEvent: TEventClass);
    procedure UpdateChart(const aPublisher: TObject; const anEvent: TEventClass);
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

uses dmController, uModel;

{$R *.dfm}

procedure TfrmMain.Button1Click(Sender: TObject);
begin
  NC.Unsubscribe(UpdateLName, TLastNameEvent);
end;

procedure TfrmMain.Button2Click(Sender: TObject);
begin
  dtmController.Prev;
end;

procedure TfrmMain.Button3Click(Sender: TObject);
begin
  dtmController.Next;
end;

procedure TfrmMain.Button4Click(Sender: TObject);
begin
  dtmController.Current.BeginUpdate;
  try
    dtmController.Current.Name := Edit5.Text;
    dtmController.Current.ValueA := StrToInt(Edit6.Text);
    dtmController.Current.ValueB := StrToInt(Edit7.Text);
    dtmController.Current.ValueC := StrToInt(Edit8.Text);
  finally
    dtmController.Current.EndUpdate;
  end;
end;

procedure TfrmMain.Edit1Change(Sender: TObject);
begin
  dtmController.FirstName := TEdit(Sender).Text;
end;

procedure TfrmMain.Edit2Change(Sender: TObject);
begin
  dtmController.LastName := Edit2.Text;
end;

procedure TfrmMain.Edit3Change(Sender: TObject);
begin
  dtmController.Age := Edit3.Text;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  NC.Subscribe(UpdateFName, TFirstNameEvent);
  NC.Subscribe(UpdateLName, TLastNameEvent);
  NC.Subscribe(UpdateAge, TAgeEvent);
  NC.Subscribe(UpdateFullName, TPersonEvent);
//  NC.Subscribe(UpdateGrade, TGradeChange);
  NC.Subscribe(UpdateGradeList, TGradeEvent);
  NC.Subscribe(UpdateChart, TGradeEvent);
  UpdateGradeList(dtmController.Current, nil);
  UpdateChart(dtmController.Current, TGradeEvent);
end;

procedure TfrmMain.UpdateAge(const aPublisher: TObject; const anEvent: TEventClass);
begin
  Label3.Caption := TdtmController(aPublisher).Age;
end;

procedure TfrmMain.UpdateChart(const aPublisher: TObject; const anEvent: TEventClass);
var
  Grades: TGrades;
begin
  if anEvent.InheritsFrom(TGradeEvent) then
  begin
    Grades := TGrades(aPublisher);

    Chart1.Title.Caption := Grades.Name;
    Series1.Clear;
    Series1.Add(Grades.ValueA, 'A', clRed);
    Series1.Add(Grades.ValueB, 'B', clBlue);
    Series1.Add(Grades.ValueC, 'C', clGreen);
  end;
end;

procedure TfrmMain.UpdateFName(const aPublisher: TObject; const anEvent: TEventClass);
begin
  Label1.Caption := TdtmController(aPublisher).FirstName;
  Edit4.Text := TdtmController(aPublisher).FirstName;
end;

procedure TfrmMain.UpdateLName(const aPublisher: TObject; const anEvent: TEventClass);
begin
  Label2.Caption := TdtmController(aPublisher).LastName;
end;

procedure TfrmMain.UpdateFullName(const aPublisher: TObject; const anEvent: TEventClass);
begin
  Label4.Caption := TdtmController(aPublisher).FirstName + ' ' + TdtmController(aPublisher).LastName;
end;

procedure TfrmMain.UpdateGradeList(const aPublisher: TObject; const anEvent: TEventClass);
var
  Grade: TGrades;
begin
  Grade := aPublisher as TGrades;
  Edit5.Text := Grade.Name;
  Edit6.Text := IntToStr(Grade.ValueA);
  Edit7.Text := IntToStr(Grade.ValueB);
  Edit8.Text := IntToStr(Grade.ValueC);
end;

procedure TfrmMain.UpdateGrade(const aPublisher: TObject; const anEvent: TEventClass);
begin
  if anEvent.InheritsFrom(TGradeNameChange) then
    Edit5.Text := TGrades(aPublisher).Name;

  if anEvent.InheritsFrom(TGradeValAChange) then
    Edit6.Text := IntToStr(TGrades(aPublisher).ValueA);

  if anEvent.InheritsFrom(TGradeValBChange) then
    Edit7.Text := IntToStr(TGrades(aPublisher).ValueB);

  if anEvent.InheritsFrom(TGradeValCChange) then
    Edit8.Text := IntToStr(TGrades(aPublisher).ValueC);
end;

procedure TfrmMain.UpdateName(const aPublisher: TObject; const anEvent: TEventClass);
begin
  if anEvent.InheritsFrom(TFirstNameEvent) then
  begin
    Label1.Caption := TdtmController(aPublisher).FirstName;
    Edit4.Text := TdtmController(aPublisher).FirstName;
    Edit1.Text := TdtmController(aPublisher).FirstName;
  end;

  if anEvent.InheritsFrom(TLastNameEvent) then
    Label2.Caption := TdtmController(aPublisher).LastName;

  if anEvent.InheritsFrom(TAgeEvent) then
    Label3.Caption := TdtmController(aPublisher).Age;
end;

end.
