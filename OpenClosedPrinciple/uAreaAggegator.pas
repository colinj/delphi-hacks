unit uAreaAggegator;

interface

uses
    SysUtils, Classes, uShapes;

type
    TAreaAggregator = class(TObject)
    public
        function SumArea(const aItems: array of IHasArea): Double;
    end;

implementation

{ TAreaAggregator }

function TAreaAggregator.SumArea(const aItems: array of IHasArea): Double;
var
    I: Integer;
begin
    Result := 0;

    for I := Low(aItems) to High(aItems) do
    begin
        Result := Result + aItems[I].Area;
    end;
end;

end.
