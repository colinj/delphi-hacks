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
    procedure UpdateFName(const aNotification: TNotification);
    procedure UpdateLName(const aNotification: TNotification);
    procedure UpdateAge(const aNotification: TNotification);
    procedure UpdateName(const aNotification: TNotification);
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
  NC.RemoveObserver(Self, 2, nil);
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

procedure TForm2.UpdateAge(const aNotification: TNotification);
begin
  Label3.Caption := TDataModule1(aNotification.Subject).Age;
end;

procedure TForm2.UpdateFName(const aNotification: TNotification);
begin
  Label1.Caption := TDataModule1(aNotification.Subject).FirstName;
end;

procedure TForm2.UpdateLName(const aNotification: TNotification);
begin
  Label2.Caption := TDataModule1(aNotification.Subject).LastName;
end;

procedure TForm2.UpdateName(const aNotification: TNotification);
begin
  Label4.Caption := TDataModule1(aNotification.Subject).FirstName + ' ' +TDataModule1(aNotification.Subject).LastName;
end;

end.
