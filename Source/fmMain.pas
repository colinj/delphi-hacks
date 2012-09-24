unit fmMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, uNotification, uEvents, uModel;

type
  TfrmMain = class(TForm)
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Edit8: TEdit;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Memo1: TMemo;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
  private
    FCurrent: TReportCard;
    procedure UpdateGrade(const aPublisher: TObject; const anEvent: TEventClass);
    procedure UpdateReportCard(const aPublisher: TObject; const anEvent: TEventClass);
    procedure UpdateEventLog(const aPublisher: TObject; const anEvent: TEventClass);
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

uses dmController, fmBarChart, fmGrid;

{$R *.dfm}

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
    dtmController.Current.ScoreA := StrToInt(Edit6.Text);
    dtmController.Current.ScoreB := StrToInt(Edit7.Text);
    dtmController.Current.ScoreC := StrToInt(Edit8.Text);
  finally
    dtmController.Current.EndUpdate;
  end;
end;

procedure TfrmMain.Button5Click(Sender: TObject);
var
  NewBarChart: TfrmBarChart;
begin
  NewBarChart := TfrmBarChart.Create(Self);
  NewBarChart.Show;
end;

procedure TfrmMain.Button6Click(Sender: TObject);
var
  NewGrid: TfrmGrid;
begin
  NewGrid := TfrmGrid.Create(Self);
  NewGrid.Show;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  FCurrent := nil;
  UpdateReportCard(dtmController.Current, TReportCardNav);
  NC.Subscribe(UpdateReportCard, TReportCardEvent);
  NC.Subscribe(UpdateEventLog, TEvent);
end;

procedure TfrmMain.UpdateEventLog(const aPublisher: TObject; const anEvent: TEventClass);
begin
  Memo1.Lines.Add(anEvent.ClassName)
end;

procedure TfrmMain.UpdateReportCard(const aPublisher: TObject; const anEvent: TEventClass);
begin
  if anEvent.InheritsFrom(TReportCardNav) then
    FCurrent := TReportCard(aPublisher);

  if aPublisher = FCurrent then
  begin
    Edit5.Text := FCurrent.Name;
    Edit6.Text := IntToStr(FCurrent.ScoreA);
    Edit7.Text := IntToStr(FCurrent.ScoreB);
    Edit8.Text := IntToStr(FCurrent.ScoreC);
  end;
end;

procedure TfrmMain.UpdateGrade(const aPublisher: TObject; const anEvent: TEventClass);
begin
  if anEvent.InheritsFrom(TReportCardNameChange) then
    Edit5.Text := TReportCard(aPublisher).Name;

  if anEvent.InheritsFrom(TReportCardScoreAChange) then
    Edit6.Text := IntToStr(TReportCard(aPublisher).ScoreA);

  if anEvent.InheritsFrom(TReportCardScoreBChange) then
    Edit7.Text := IntToStr(TReportCard(aPublisher).ScoreB);

  if anEvent.InheritsFrom(TReportCardScoreCChange) then
    Edit8.Text := IntToStr(TReportCard(aPublisher).ScoreC);
end;

end.
