unit fmMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, uEventAgg, uEvents, uModel;

type
  TfrmMain = class(TForm)
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Edit8: TEdit;
    btnPrev: TButton;
    btnNext: TButton;
    btnBarChart: TButton;
    btnGrid: TButton;
    btnPieChart: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btnPrevClick(Sender: TObject);
    procedure btnNextClick(Sender: TObject);
    procedure btnBarChartClick(Sender: TObject);
    procedure btnGridClick(Sender: TObject);
    procedure Edit5Exit(Sender: TObject);
    procedure btnPieChartClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FCurrent: TReportCard;
    procedure UpdateForm(const aPublisher: TObject; const anEvent: TEventClass);
    procedure UpdateModel;
  end;

var
  frmMain: TfrmMain;

implementation

uses dmController, fmBarChart, fmGrid, fmPieChart;

{$R *.dfm}

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  FCurrent := nil;
  UpdateForm(dtmController.Current, TReportCardNav);
  EA.Subscribe(UpdateForm, TReportCardEvent);
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  EA.Unsubscribe(UpdateForm);
end;

procedure TfrmMain.btnPrevClick(Sender: TObject);
begin
  dtmController.Prev;
end;

procedure TfrmMain.btnNextClick(Sender: TObject);
begin
  dtmController.Next;
end;

procedure TfrmMain.Edit5Exit(Sender: TObject);
begin
  if TEdit(Sender).Modified then
    UpdateModel;
end;

procedure TfrmMain.UpdateModel;
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

procedure TfrmMain.UpdateForm(const aPublisher: TObject; const anEvent: TEventClass);
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

procedure TfrmMain.btnPieChartClick(Sender: TObject);
var
  NewChart: TfrmPieChart;
begin
  NewChart := TfrmPieChart.Create(Self);
  NewChart.Show;
end;

procedure TfrmMain.btnBarChartClick(Sender: TObject);
var
  NewBarChart: TfrmBarChart;
begin
  NewBarChart := TfrmBarChart.Create(Self);
  NewBarChart.Show;
end;

procedure TfrmMain.btnGridClick(Sender: TObject);
var
  NewGrid: TfrmGrid;
begin
  NewGrid := TfrmGrid.Create(Self);
  NewGrid.Show;
end;


end.
