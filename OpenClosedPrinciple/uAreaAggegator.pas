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
        Result := Result + Shape.Area;
    end;
end;

end.
