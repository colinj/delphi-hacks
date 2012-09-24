unit uShape;

interface

uses
  ObjFactory;

type
  TShape = class(TBaseObject)
  private
    FName: string;
  protected
    procedure SetName(const aName: string);
  public
    constructor Create; override;
    function ToString: string; override;
    property Name: string read FName;
  end;

  TCircle = class(TShape)
  public
    constructor Create; override;
    function ToString: string; override;
  end;

  TSquare = class(TShape)
  public
    constructor Create; override;
    function ToString: string; override;
  end;

  TTriangle = class(TShape)
  public
    constructor Create; override;
    function ToString: string; override;
  end;

implementation

{ TShape }

constructor TShape.Create;
begin
  FName := 'shape';
end;

procedure TShape.SetName(const aName: string);
begin
  FName := aName;
end;

function TShape.ToString: string;
begin
  Result := 'I am a shape.';
end;

{ TCircle }

constructor TCircle.Create;
begin
  SetName('circle');
end;

function TCircle.ToString: string;
begin
  Result := 'I am a circle.';
end;

{ TSquare }

constructor TSquare.Create;
begin
  SetName('square');
end;

function TSquare.ToString: string;
begin
  Result := 'I am a square.';
end;

{ TTriangle }

constructor TTriangle.Create;
begin
  SetName('triangle');
end;

function TTriangle.ToString: string;
begin
  Result := 'I am a triangle.';
end;

initialization

  ObjectFactory.RegisterClass('circle', TCircle);
  ObjectFactory.RegisterClass('square', TSquare);
  ObjectFactory.RegisterClass('triangle', TTriangle);

end.
