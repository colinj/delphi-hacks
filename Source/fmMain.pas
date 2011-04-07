unit fmMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, uNotification;

type
  TForm2 = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure Edit3Change(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    procedure UpdateFName(const aSubject: TObject);
    procedure UpdateLName(const aSubject: TObject);
    procedure UpdateAge(const aSubject: TObject);
    procedure UpdateName(const aSubject: TObject);
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

uses dmController;

{$R *.dfm}

procedure TForm2.Button1Click(Sender: TObject);
begin
  NC.RemoveObserver(UpdateLName, 2, nil);
end;

procedure TForm2.Edit1Change(Sender: TObject);
begin
  DataModule1.FirstName := Edit1.Text;
end;

procedure TForm2.Edit2Change(Sender: TObject);
begin
  DataModule1.LastName := Edit2.Text;
end;

procedure TForm2.Edit3Change(Sender: TObject);
begin
  DataModule1.Age := Edit3.Text;
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
  NC.AddObserver(UpdateFName, 1);
  NC.AddObserver(UpdateLName, 2);
  NC.AddObserver(UpdateAge, 3);
  NC.AddObserver(UpdateName, 1);
  NC.AddObserver(UpdateName, 2);
end;

procedure TForm2.UpdateAge(const aSubject: TObject);
begin
  Label3.Caption := TDataModule1(aSubject).Age;
end;

procedure TForm2.UpdateFName(const aSubject: TObject);
begin
  Label1.Caption := TDataModule1(aSubject).FirstName;
end;

procedure TForm2.UpdateLName(const aSubject: TObject);
begin
  Label2.Caption := TDataModule1(aSubject).LastName;
end;

procedure TForm2.UpdateName(const aSubject: TObject);
begin
  Label4.Caption := TDataModule1(aSubject).FirstName + ' ' +TDataModule1(aSubject).LastName;
end;

end.
