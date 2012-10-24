unit uAreaAggegator;

interface

uses
    SysUtils, Classes, uShapes;

type
    TAreaAggregator = class(TObject)
    public
        function SumArea(const aShapes: array of TRectangle): Double;
    end;

implementation

{ TAreaAggregator }

function TAreaAggregator.SumArea(const aShapes: array of TRectangle): Double;
var
    Rectangle: TRectangle;
begin
    Result := 0;

    for Rectangle in aShapes do
    begin
        Result := Result + Rectangle.Height * Rectangle.Width;
    end;
end;

end.
