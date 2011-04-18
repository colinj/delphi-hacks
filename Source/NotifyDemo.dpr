program NotifyDemo;

uses
  Forms,
  fmMain in 'fmMain.pas' {frmMain},
  uNotification in 'uNotification.pas',
  uModel in 'uModel.pas',
  dmController in 'dmController.pas' {dtmController: TDataModule},
  uEvents in 'uEvents.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TdtmController, dtmController);
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
