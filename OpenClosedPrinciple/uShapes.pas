unit uShapes;

interface

type
    TShape = class(TObject);

    TRectangle = class(TShape)
    private
        FHeight: Double;
        FWidth: Double;
    public
        constructor Create(const aHeight, aWidth: Double);
        property Height: Double read FHeight write FHeight;
        property Width: Double read FWidth write FWidth;
    end;

    TCircle = class(TShape)
    private
        FRadius: Double;
    public
        constructor Create(const aRadius: Double);
        property Radius: Double read FRadius write FRadius;
    end;

    TTriangle = class(TShape)
    private
        FBase: Double;
        FHeight: Double;
    public
        constructor Create(const aBase, aHeight: Double);
        property Base: Double read FBase write FBase;
        property Height: Double read FHeight write FHeight;
    end;

implementation

{ TRectangle }

constructor TRectangle.Create(const aHeight, aWidth: Double);
begin
    inherited Create;
    FHeight := aHeight;
    FWidth := aWidth;
end;

{ TCircle }

constructor TCircle.Create(const aRadius: Double);
begin
    inherited Create;
    FRadius := aRadius;
end;

{ TTriangle }

constructor TTriangle.Create(const aBase, aHeight: Double);
begin
    inherited Create;
    FBase := aBase;
    FHeight := aHeight;
end;

end.
