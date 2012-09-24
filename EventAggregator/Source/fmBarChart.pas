unit fmBarChart;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, TeEngine, Series, TeeProcs, Chart, uEventAgg, uEvents, uModel;

type
  TfrmBarChart = class(TForm)
    Chart1: TChart;
    Series1: TBarSeries;
    pnlFooter: TPanel;
    btnClose: TButton;
    CheckBox1: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CheckBox1Click(Sender: TObject);
  private
    FCurrent: TReportCard;
    procedure UpdateChart(const aPublisher: TObject; const anEvent: TEventClass);
  end;

var
  frmBarChart: TfrmBarChart;

implementation

uses dmController;

{$R *.dfm}

{ TfrmBarChart }

procedure TfrmBarChart.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmBarChart.CheckBox1Click(Sender: TObject);
begin
  EA.Unsubscribe(UpdateChart);
  if CheckBox1.Checked then
    EA.Subscribe(UpdateChart, TReportCardEvent)
  else
    EA.Subscribe(UpdateChart, TReportCardChange);
end;

procedure TfrmBarChart.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmBarChart.FormCreate(Sender: TObject);
begin
  FCurrent := nil;
  UpdateChart(dtmController.Current, TReportCardNav);

  EA.Subscribe(UpdateChart, TReportCardEvent);
end;

procedure TfrmBarChart.FormDestroy(Sender: TObject);
begin
  EA.Unsubscribe(UpdateChart);
end;

procedure TfrmBarChart.UpdateChart(const aPublisher: TObject; const anEvent: TEventClass);
begin
  // If it's a navigational event, make this object the 'Current' object.
  if anEvent.InheritsFrom(TReportCardNav) then
    FCurrent := TReportCard(aPublisher);

  if aPublisher = FCurrent then
  begin
    Chart1.Title.Caption := FCurrent.Name;
    Series1.Clear;
    Series1.Add(FCurrent.ScoreA, 'A', clRed);
    Series1.Add(FCurrent.ScoreB, 'B', clBlue);
    Series1.Add(FCurrent.ScoreC, 'C', clGreen);
  end;
end;

end.
