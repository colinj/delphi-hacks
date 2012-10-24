unit uShapes;

interface

type
    TRectangle = class(TObject)
    private
        FHeight: Double;
        FWidth: Double;
    public
        constructor Create(const aHeight, aWidth: Double);
        property Height: Double read FHeight write FHeight;
        property Width: Double read FWidth write FWidth;
    end;

implementation

{ TRectangle }

constructor TRectangle.Create(const aHeight, aWidth: Double);
begin
    inherited Create;
    FHeight := aHeight;
    FWidth := aWidth;
end;

end.
