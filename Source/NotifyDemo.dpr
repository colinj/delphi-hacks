program NotifyDemo;

uses
  Forms,
  fmMain in 'fmMain.pas' {Form2},
  uNotification in 'uNotification.pas',
  uModel in 'uModel.pas',
  dmController in 'dmController.pas' {DataModule1: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDataModule1, DataModule1);
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
