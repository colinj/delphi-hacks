unit uAreaAggegator;

interface

uses
    SysUtils, Classes, uShapes;

type
    TAreaAggregator = class(TObject)
    public
        function SumArea(const aShapes: array of TShape): Double;
    end;

implementation

{ TAreaAggregator }

function TAreaAggregator.SumArea(const aShapes: array of TShape): Double;
var
    Shape: TShape;
begin
    Result := 0;

    for Shape in aShapes do
    begin
        if Shape is TRectangle then
            Result := Result + (TRectangle(Shape).Height * TRectangle(Shape).Width);

        if Shape is TCircle then
            Result := Result + (Pi * TCircle(Shape).Radius * TCircle(Shape).Radius);

        if Shape is TTriangle then
            Result := Result + (TTriangle(Shape).Base * TTriangle(Shape).Height / 2);
    end;
end;

end.
