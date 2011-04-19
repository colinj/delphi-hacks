unit fmGrid;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Grids, uNotification, uEvents;

type
  TfrmGrid = class(TForm)
    pnlFooter: TPanel;
    btnClose: TButton;
    StringGrid1: TStringGrid;
    procedure FormResize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    FOldRow: Integer;
    procedure InitialiseGrid;
    procedure UpdateGrid(const aPublisher: TObject; const anEvent: TEventClass);
    procedure UpdateCursor(const aPublisher: TObject; const anEvent: TEventClass);
  public
  end;

var
  frmGrid: TfrmGrid;

implementation

uses dmController, uModel;

{$R *.dfm}

procedure TfrmGrid.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmGrid.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmGrid.FormCreate(Sender: TObject);
begin
  InitialiseGrid;
  NC.Subscribe(UpdateGrid, TGradeChange);
  NC.Subscribe(UpdateCursor, TGradeNav);
end;

procedure TfrmGrid.FormDestroy(Sender: TObject);
begin
  NC.Unsubscribe(UpdateGrid);
  NC.UnSubscribe(UpdateCursor);
end;

procedure TfrmGrid.FormResize(Sender: TObject);
begin
  StringGrid1.DefaultColWidth := StringGrid1.ClientWidth div 5;
end;

procedure TfrmGrid.InitialiseGrid;
var
  I: Integer;
begin
  FOldRow := 0;
  StringGrid1.Rows[0].CommaText := ' ,Name,A,B,C';
  StringGrid1.RowCount := dtmController.Grades.Count + 1;
  for I := 0 to dtmController.Grades.Count - 1 do
  begin
    StringGrid1.Objects[0, I + 1] := dtmController.Grades.Items[I];
    UpdateCursor(dtmController.Grades.Items[I], nil);
    UpdateGrid(dtmController.Grades.Items[I], nil);
  end;
end;

procedure TfrmGrid.UpdateCursor(const aPublisher: TObject; const anEvent: TEventClass);
var
  RowNo: Integer;
begin

  RowNo := StringGrid1.Cols[0].IndexOfObject(aPublisher);
  if RowNo > 0 then
  begin
    if aPublisher = dtmController.Current then
    begin
      StringGrid1.Cells[0, FOldRow] := '';
      StringGrid1.Cells[0, RowNo] := '  >>>>>';
      FOldRow := RowNo;
    end
    else
      StringGrid1.Cells[0, RowNo] := '';
  end;
end;

procedure TfrmGrid.UpdateGrid(const aPublisher: TObject; const anEvent: TEventClass);
var
  RowNo: Integer;
begin
  RowNo := StringGrid1.Cols[0].IndexOfObject(aPublisher);
  if RowNo > 0 then
  begin
    StringGrid1.Cells[1, RowNo] := TGrades(aPublisher).Name;
    StringGrid1.Cells[2, RowNo] := IntToStr(TGrades(aPublisher).ValueA);
    StringGrid1.Cells[3, RowNo] := IntToStr(TGrades(aPublisher).ValueB);
    StringGrid1.Cells[4, RowNo] := IntToStr(TGrades(aPublisher).ValueC);
  end;
end;


end.
