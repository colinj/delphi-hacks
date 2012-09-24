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
    procedure StringGrid1Enter(Sender: TObject);
    procedure StringGrid1SetEditText(Sender: TObject; ACol, ARow: Integer; const Value: string);
    procedure StringGrid1Exit(Sender: TObject);
    procedure StringGrid1SelectCell(Sender: TObject; ACol, ARow: Integer; var CanSelect: Boolean);
  private
    FOldRow: Integer;
    FEditingCol: Integer;
    FEditingRow: Integer;
    procedure InitialiseGrid;
    procedure UpdateGrid(const aPublisher: TObject; const anEvent: TEventClass);
    procedure UpdateCursor(const aPublisher: TObject; const anEvent: TEventClass);
    procedure UpdateObject(const aCol, aRow: Integer);
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
  NC.Subscribe(UpdateGrid, TReportCardChange);
  NC.Subscribe(UpdateCursor, TReportCardNav);
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
  StringGrid1.RowCount := dtmController.ReportCards.Count + 1;
  for I := 0 to dtmController.ReportCards.Count - 1 do
  begin
    StringGrid1.Objects[0, I + 1] := dtmController.ReportCards.Items[I];
    UpdateCursor(dtmController.ReportCards.Items[I], nil);
    UpdateGrid(dtmController.ReportCards.Items[I], nil);
  end;
end;

procedure TfrmGrid.StringGrid1Enter(Sender: TObject);
begin
  FEditingCol := -1;
  FEditingRow := -1;
end;

procedure TfrmGrid.StringGrid1Exit(Sender: TObject);
begin
  if (FEditingCol <> -1) and (FEditingRow <> -1) then
  begin
    UpdateObject(FEditingCol, FEditingRow);
  end;
end;

procedure TfrmGrid.StringGrid1SelectCell(Sender: TObject; ACol, ARow: Integer; var CanSelect: Boolean);
begin
  if (ACol <> FEditingCol) or (ARow <> FEditingRow) then
    UpdateObject(FEditingCol, FEditingRow);
end;

procedure TfrmGrid.StringGrid1SetEditText(Sender: TObject; ACol, ARow: Integer; const Value: string);
begin
  if not StringGrid1.EditorMode then
    UpdateObject(ACol, ARow)
  else
  begin
    FEditingCol := ACol;
    FEditingRow := ARow;
  end;
//
//  if (ACol <> FEditingCol) and (ARow <> FEditingRow) then
//  begin
//    if (FEditingCol <> -1) and (FEditingRow <> -1) then
//      UpdateObject(FEditingCol, FEditingRow);
//    FEditingCol := ACol;
//    FEditingRow := ARow;
//  end;
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
    StringGrid1.Cells[1, RowNo] := TReportCard(aPublisher).Name;
    StringGrid1.Cells[2, RowNo] := IntToStr(TReportCard(aPublisher).ScoreA);
    StringGrid1.Cells[3, RowNo] := IntToStr(TReportCard(aPublisher).ScoreB);
    StringGrid1.Cells[4, RowNo] := IntToStr(TReportCard(aPublisher).ScoreC);
  end;
end;

procedure TfrmGrid.UpdateObject(const aCol, aRow: Integer);
var
  Grade: TReportCard;
begin
  if (aCol < 0) or (aRow < 0) then
    Exit;

  Grade := TReportCard(StringGrid1.Objects[0, aRow]);
  case aCol of
    1: Grade.Name := StringGrid1.Cells[aCol, aRow];
    2: Grade.ScoreA := StrToInt(StringGrid1.Cells[aCol, aRow]);
    3: Grade.ScoreB := StrToInt(StringGrid1.Cells[aCol, aRow]);
    4: Grade.ScoreC := StrToInt(StringGrid1.Cells[aCol, aRow]);
  end;
end;

end.
