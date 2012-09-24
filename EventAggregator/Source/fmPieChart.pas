unit fmPieChart;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, TeEngine, Series, TeeProcs, Chart, uEventAgg, uEvents, uModel;

type
  TfrmPieChart = class(TForm)
    Chart1: TChart;
    pnlFooter: TPanel;
    btnClose: TButton;
    CheckBox1: TCheckBox;
    Series1: TPieSeries;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CheckBox1Click(Sender: TObject);
  private
    FAngle: Integer;
    FCurrent: TReportCard;
    procedure UpdateChart(const aPublisher: TObject; const anEvent: TEventClass);
  public
    { Public declarations }
  end;

var
  frmPieChart: TfrmPieChart;

implementation

uses dmController;

{$R *.dfm}

{ TfrmPieChart }

procedure TfrmPieChart.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmPieChart.CheckBox1Click(Sender: TObject);
begin
  EA.Unsubscribe(UpdateChart);
  if CheckBox1.Checked then
    EA.Subscribe(UpdateChart, TReportCardEvent)
  else
    EA.Subscribe(UpdateChart, TReportCardChange);
end;

procedure TfrmPieChart.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmPieChart.FormCreate(Sender: TObject);
begin
  FCurrent := nil;
  FAngle := 0;
  UpdateChart(dtmController.Current, TReportCardNav);

  EA.Subscribe(UpdateChart, TReportCardEvent);
end;

procedure TfrmPieChart.FormDestroy(Sender: TObject);
begin
  EA.Unsubscribe(UpdateChart);
end;

procedure TfrmPieChart.UpdateChart(const aPublisher: TObject; const anEvent: TEventClass);
begin
  // If it's a navigational event, make this object the 'Current' object.
  if anEvent.InheritsFrom(TReportCardNav) then
  begin
    FCurrent := TReportCard(aPublisher);
    Inc(FAngle,15);
    FAngle := FAngle mod 360;
    Series1.RotationAngle := FAngle;
  end;

  if aPublisher = FCurrent then
  begin
    Chart1.Title.Caption := FCurrent.Name;
    Series1.Clear;
    Series1.Add(FCurrent.ScoreA, 'A', clAqua);
    Series1.Add(FCurrent.ScoreB, 'B', clPurple);
    Series1.Add(FCurrent.ScoreC, 'C', clYellow);
  end;
end;

end.
