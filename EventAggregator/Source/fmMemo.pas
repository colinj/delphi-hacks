unit fmMemo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
  private
    procedure UpdateForm(const aPublisher: TObject; const anEvent: TEventClass);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

{ TForm1 }

procedure TForm1.UpdateForm(const aPublisher: TObject; const anEvent: TEventClass);
begin
  Memo1.Lines.Add(anEvent.ClassName)
end;

end.
