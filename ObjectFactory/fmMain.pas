unit fmMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TForm3 = class(TForm)
    Memo1: TMemo;
    Button1: TButton;
    RadioGroup1: TRadioGroup;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

uses ObjFactory, uShape;

{$R *.dfm}

procedure TForm3.Button1Click(Sender: TObject);
const
  SHAPE_STR: array[0..2] of string = ('circle', 'square', 'triangle');
var
  NewShape: TShape;
begin
  NewShape := TShape(ObjectFactory.CreateInstance(SHAPE_STR[RadioGroup1.ItemIndex]));
  try
    Memo1.Lines.Add(NewShape.ToString);
    Memo1.Lines.Add('My name is ' + NewShape.Name)
  finally
    NewShape.Free;
  end;
end;

end.
