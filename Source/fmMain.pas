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
    Edit4: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure Edit3Change(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    procedure UpdateFName(const aPublisher: TObject; const aTopic: Integer);
    procedure UpdateLName(const aPublisher: TObject; const aTopic: Integer);
    procedure UpdateAge(const aPublisher: TObject; const aTopic: Integer);
    procedure UpdateFullName(const aPublisher: TObject; const aTopic: Integer);
    procedure UpdateName(const aPublisher: TObject; const aTopic: Integer);
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
  NC.Unsubscribe(UpdateName, 2, nil);
end;

procedure TForm2.Edit1Change(Sender: TObject);
begin
  DataModule1.FirstName := TEdit(Sender).Text;
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
  NC.Subscribe(UpdateName, N_CHANGE_FNAME);
  NC.Subscribe(UpdateName, N_CHANGE_LNAME);
  NC.Subscribe(UpdateName, N_CHANGE_AGE);
  NC.Subscribe(UpdateFullName, N_CHANGE_FNAME);
  NC.Subscribe(UpdateFullName, N_CHANGE_LNAME);
end;

procedure TForm2.UpdateAge(const aPublisher: TObject; const aTopic: Integer);
begin
  Label3.Caption := TDataModule1(aPublisher).Age;
end;

procedure TForm2.UpdateFName(const aPublisher: TObject; const aTopic: Integer);
begin
  Label1.Caption := TDataModule1(aPublisher).FirstName;
  Edit4.Text := TDataModule1(aPublisher).FirstName;
end;

procedure TForm2.UpdateLName(const aPublisher: TObject; const aTopic: Integer);
begin
  Label2.Caption := TDataModule1(aPublisher).LastName;
end;

procedure TForm2.UpdateFullName(const aPublisher: TObject; const aTopic: Integer);
begin
  Label4.Caption := TDataModule1(aPublisher).FirstName + ' ' +TDataModule1(aPublisher).LastName;
end;

procedure TForm2.UpdateName(const aPublisher: TObject; const aTopic: Integer);
begin
  case aTopic of
    N_CHANGE_FNAME:
      begin
        Label1.Caption := TDataModule1(aPublisher).FirstName;
        Edit4.Text := TDataModule1(aPublisher).FirstName;
        Edit1.Text := TDataModule1(aPublisher).FirstName;
      end;
    N_CHANGE_LNAME:
      Label2.Caption := TDataModule1(aPublisher).LastName;

    N_CHANGE_AGE:
      Label3.Caption := TDataModule1(aPublisher).Age;
  end;
end;

end.
