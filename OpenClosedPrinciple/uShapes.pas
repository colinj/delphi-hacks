unit uShapes;

interface

type
    IHasArea = interface
        function GetArea: Double;
        property Area: Double read GetArea;
    end;

    TRectangle = class(TInterfacedObject, IHasArea)
    private
        FHeight: Double;
        FWidth: Double;
        function GetArea: Double;
    public
        constructor Create(const aHeight, aWidth: Double);
    end;

    TCircle = class(TInterfacedObject, IHasArea)
    private
        FRadius: Double;
        function GetArea: Double;
    public
        constructor Create(const aRadius: Double);
    end;

    TTriangle = class(TInterfacedObject, IHasArea)
    private
        FBase: Double;
        FHeight: Double;
        function GetArea: Double;
    public
        constructor Create(const aBase, aHeight: Double);
    end;

    TSquare = class(TInterfacedObject, IHasArea)
    private
        FSide: Double;
        function GetArea: Double;
    public
        constructor Create(const aSide: Double);
    end;

implementation

{ TRectangle }

constructor TRectangle.Create(const aHeight, aWidth: Double);
begin
    inherited Create;
    FHeight := aHeight;
    FWidth := aWidth;
end;

function TRectangle.GetArea: Double;
begin
    Result := FHeight * FWidth;
end;

{ TCircle }

constructor TCircle.Create(const aRadius: Double);
begin
    inherited Create;
    FRadius := aRadius;
end;

function TCircle.GetArea: Double;
begin
    Result := Pi * FRadius * FRadius;
end;

{ TTriangle }

constructor TTriangle.Create(const aBase, aHeight: Double);
begin
    inherited Create;
    FBase := aBase;
    FHeight := aHeight;
end;

function TTriangle.GetArea: Double;
begin
    Result := FBase * FHeight / 2;
end;

{ TSquare }

constructor TSquare.Create(const aSide: Double);
begin
    inherited Create;
    FSide := aSide;
end;

function TSquare.GetArea: Double;
begin
    Result := FSide * FSide;
end;

end.
