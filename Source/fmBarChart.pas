unit fmBarChart;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, TeEngine, Series, TeeProcs, Chart, uNotification, uEvents;

type
  TfrmBarChart = class(TForm)
    Chart1: TChart;
    Series1: TBarSeries;
    pnlFooter: TPanel;
    btnClose: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    procedure UpdateChart(const aPublisher: TObject; const anEvent: TEventClass);
  public
    { Public declarations }
  end;

var
  frmBarChart: TfrmBarChart;

implementation

uses dmController, uModel;

{$R *.dfm}

{ TfrmBarChart }

procedure TfrmBarChart.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmBarChart.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmBarChart.FormCreate(Sender: TObject);
begin
  UpdateChart(dtmController.Current, TGradeEvent);

  NC.Subscribe(UpdateChart, TGradeEvent);
end;

procedure TfrmBarChart.FormDestroy(Sender: TObject);
begin
  NC.Unsubscribe(UpdateChart);
end;

procedure TfrmBarChart.UpdateChart(const aPublisher: TObject; const anEvent: TEventClass);
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

end.
