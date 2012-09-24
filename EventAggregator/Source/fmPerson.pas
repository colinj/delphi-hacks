unit fmPerson;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, uNotification, uEvents, uModel;

type
  TfrmPerson = class(TForm)
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
    procedure UpdateFName(const aPublisher: TObject; const anEvent: TEventClass);
    procedure UpdateLName(const aPublisher: TObject; const anEvent: TEventClass);
    procedure UpdateAge(const aPublisher: TObject; const anEvent: TEventClass);
    procedure UpdateFullName(const aPublisher: TObject; const anEvent: TEventClass);
    procedure UpdateName(const aPublisher: TObject; const anEvent: TEventClass);
  public
    { Public declarations }
  end;

var
  frmPerson: TfrmPerson;

implementation

uses dmController;

{$R *.dfm}

procedure TfrmPerson.Button1Click(Sender: TObject);
begin
  NC.Unsubscribe(UpdateLName, TLastNameEvent);
end;

procedure TfrmPerson.Edit1Change(Sender: TObject);
begin
  dtmController.FirstName := TEdit(Sender).Text;
end;

procedure TfrmPerson.Edit2Change(Sender: TObject);
begin
  dtmController.LastName := Edit2.Text;
end;

procedure TfrmPerson.Edit3Change(Sender: TObject);
begin
  dtmController.Age := Edit3.Text;
end;

procedure TfrmPerson.FormCreate(Sender: TObject);
begin
  NC.Subscribe(UpdateFName, TFirstNameEvent);
  NC.Subscribe(UpdateLName, TLastNameEvent);
  NC.Subscribe(UpdateAge, TAgeEvent);
  NC.Subscribe(UpdateFullName, TPersonEvent);
end;

procedure TfrmPerson.UpdateAge(const aPublisher: TObject; const anEvent: TEventClass);
begin
  Label3.Caption := TdtmController(aPublisher).Age;
end;

procedure TfrmPerson.UpdateFName(const aPublisher: TObject; const anEvent: TEventClass);
begin
  Label1.Caption := TdtmController(aPublisher).FirstName;
  Edit4.Text := TdtmController(aPublisher).FirstName;
end;

procedure TfrmPerson.UpdateLName(const aPublisher: TObject; const anEvent: TEventClass);
begin
  Label2.Caption := TdtmController(aPublisher).LastName;
end;

procedure TfrmPerson.UpdateFullName(const aPublisher: TObject; const anEvent: TEventClass);
begin
  Label4.Caption := TdtmController(aPublisher).FirstName + ' ' + TdtmController(aPublisher).LastName;
end;

procedure TfrmPerson.UpdateName(const aPublisher: TObject; const anEvent: TEventClass);
begin
  if anEvent.InheritsFrom(TFirstNameEvent) then
  begin
    Label1.Caption := TdtmController(aPublisher).FirstName;
    Edit4.Text := TdtmController(aPublisher).FirstName;
    Edit1.Text := TdtmController(aPublisher).FirstName;
  end;

  if anEvent.InheritsFrom(TLastNameEvent) then
    Label2.Caption := TdtmController(aPublisher).LastName;

  if anEvent.InheritsFrom(TAgeEvent) then
    Label3.Caption := TdtmController(aPublisher).Age;
end;

end.
