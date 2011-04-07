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
    procedure UpdateFName(const aSubject: TObject; const aNotifyId: Integer);
    procedure UpdateLName(const aSubject: TObject; const aNotifyId: Integer);
    procedure UpdateAge(const aSubject: TObject; const aNotifyId: Integer);
    procedure UpdateFullName(const aSubject: TObject; const aNotifyId: Integer);
    procedure UpdateName(const aSubject: TObject; const aNotifyId: Integer);
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
  NC.RemoveObserver(UpdateName, 2, nil);
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
//  NC.AddObserver(UpdateFName, 1);
//  NC.AddObserver(UpdateLName, 2);
//  NC.AddObserver(UpdateAge, 3);
  NC.AddObserver(UpdateName, N_CHANGE_FNAME);
  NC.AddObserver(UpdateName, N_CHANGE_LNAME);
  NC.AddObserver(UpdateName, N_CHANGE_AGE);
  NC.AddObserver(UpdateFullName, N_CHANGE_FNAME);
  NC.AddObserver(UpdateFullName, N_CHANGE_LNAME);
end;

procedure TForm2.UpdateAge(const aSubject: TObject; const aNotifyId: Integer);
begin
  Label3.Caption := TDataModule1(aSubject).Age;
end;

procedure TForm2.UpdateFName(const aSubject: TObject; const aNotifyId: Integer);
begin
  Label1.Caption := TDataModule1(aSubject).FirstName;
end;

procedure TForm2.UpdateLName(const aSubject: TObject; const aNotifyId: Integer);
begin
  Label2.Caption := TDataModule1(aSubject).LastName;
end;

procedure TForm2.UpdateFullName(const aSubject: TObject; const aNotifyId: Integer);
begin
  Label4.Caption := TDataModule1(aSubject).FirstName + ' ' +TDataModule1(aSubject).LastName;
end;

procedure TForm2.UpdateName(const aSubject: TObject; const aNotifyId: Integer);
begin
  case aNotifyId of
    N_CHANGE_FNAME:
      Label1.Caption := TDataModule1(aSubject).FirstName;

    N_CHANGE_LNAME:
      Label2.Caption := TDataModule1(aSubject).LastName;

    N_CHANGE_AGE:
      Label3.Caption := TDataModule1(aSubject).Age;
  end;
end;

end.
