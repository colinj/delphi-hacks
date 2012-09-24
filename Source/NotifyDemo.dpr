program NotifyDemo;

uses
  Forms,
  fmMain in 'fmMain.pas' {frmMain},
  uEventAgg in 'uEventAgg.pas',
  uModel in 'uModel.pas',
  dmController in 'dmController.pas' {dtmController: TDataModule},
  uEvents in 'uEvents.pas',
  fmBarChart in 'fmBarChart.pas' {frmBarChart},
  fmGrid in 'fmGrid.pas' {frmGrid},
  fmPieChart in 'fmPieChart.pas' {frmPieChart};

{$R *.res}

begin
  Application.Initialize;
//  Application.MainFormOnTaskbar := True;
  Application.MainFormOnTaskbar := False;
  Application.CreateForm(TdtmController, dtmController);
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
