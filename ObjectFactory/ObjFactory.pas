unit ObjFactory;

interface

uses
  SysUtils, Classes;

type
  EFactoryException = class(Exception);

  TBaseObject = class(TObject)
  public
    constructor Create; virtual; abstract;
  end;

  TBaseClass = class of TBaseObject;

  TObjectFactory = class(TObject)
  private
    FItems: TStringList;
  protected
  public
    constructor Create;
    destructor Destroy; override;
    function GetClass(const AName: string): TBaseClass;
    function CreateInstance(const aName: string): TBaseObject;
    procedure RegisterClass(const AName: string; const AClass: TBaseClass);
  end;

function ObjectFactory: TObjectFactory;

implementation

var
  FactoryImpl: TObjectFactory = nil;

{ ObjectFactory }

function ObjectFactory: TObjectFactory;
begin
  if FactoryImpl = nil then
    FactoryImpl := TObjectFactory.Create;

  Result := FactoryImpl;
end;

{ TObjectFactory }

constructor TObjectFactory.Create;
begin
  inherited Create;
  FItems := TStringList.Create;
end;

function TObjectFactory.CreateInstance(const aName: string): TBaseObject;
begin
  Result := Self.GetClass(aName).Create;
end;

destructor TObjectFactory.Destroy;
begin
  FItems.Free;
  inherited;
end;

function TObjectFactory.GetClass(const AName: string): TBaseClass;
var
  I: Integer;
begin
  I := FItems.IndexOf(UpperCase(AName));
  if I = -1 then
    raise EFactoryException.CreateFmt('No class: %s exists', [AName])
  else
    Result := TBaseClass(FItems.Objects[I]);
end;

procedure TObjectFactory.RegisterClass(const AName: string; const AClass: TBaseClass);
var
  ItemName: string;
  I: Integer;
begin
  ItemName := UpperCase(AName);
  I := FItems.IndexOf(ItemName);
  if I = -1 then
    FItems.AddObject(ItemName, TObject(AClass))
  else
    raise EFactoryException.CreateFmt('Class: %s has already been registered', [AName]);
end;

initialization

finalization
  FactoryImpl.Free;

end.
