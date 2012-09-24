program ObjFactoryDemo;

uses
  Forms,
  fmMain in 'fmMain.pas' {Form3},
  ObjFactory in 'ObjFactory.pas',
  uShape in 'uShape.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm3, Form3);
  Application.Run;
end.
