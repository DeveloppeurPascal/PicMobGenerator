unit uProjetPIMG;

interface

uses
  System.Classes, System.Generics.Collections, System.UITypes, FMX.Graphics,
  FMX.Objects, FMX.RS.SVGCtrls, FMX.RS.SVGTypes;

const
  // Version maximale du format de fichier PIMG supportée
  CCurrentFileVersion = 5;
  // Version maximale du format de stockage de la liste des couches
  CCurrentLayerListVersion = 1;
  // Version maximale du format de couche de base supportée
  CCurrentLayerVersion = 1;
  // Version maximale du format de couche Image supportée
  CCurrentImageVersion = 5;
  // Version maximale du format de couche SVG supportée
  CCurrentSVGVersion = 1;
  // Version maximale du format de couche Chemin supportée
  CCurrentPathVersion = 4;
  // Version maximale du format de couche Rectangle supportée
  CCurrentRectangleVersion = 3;

type
{$SCOPEDENUMS on}
  TPIMGCoucheType = (Rien = 0, Chemin = 1, Image = 2, Rectangle = 3, SVG = 4);

  TPIMGCouche = class
  private
    FTypeDeCouche: TPIMGCoucheType;
    FMargeGauche: byte;
    FMargeBasse: byte;
    FMargeHaute: byte;
    FMargeDroite: byte;
    procedure SetMargeBasse(const Value: byte);
    procedure SetMargeDroite(const Value: byte);
    procedure SetMargeGauche(const Value: byte);
    procedure SetMargeHaute(const Value: byte);
  public
    property TypeDeCouche: TPIMGCoucheType read FTypeDeCouche;
    property MargeHaute: byte read FMargeHaute write SetMargeHaute;
    property MargeDroite: byte read FMargeDroite write SetMargeDroite;
    property MargeBasse: byte read FMargeBasse write SetMargeBasse;
    property MargeGauche: byte read FMargeGauche write SetMargeGauche;
    procedure SaveToStream(s: TStream); virtual;
    procedure LoadFromStream(s: TStream); virtual;
    constructor Create; virtual;
  end;

  TPIMGCoucheChemin = class(TPIMGCouche)
  private
    FColor: TAlphaColor;
    FPathData: string;
    FFillColor: TAlphaColor;
    FWrapMode: TPathWrapMode;
    procedure SetColor(const Value: TAlphaColor);
    procedure SetPathData(const Value: string);
    procedure SetFillColor(const Value: TAlphaColor);
    procedure SetWrapMode(const Value: TPathWrapMode);
  public
    property PathData: string read FPathData write SetPathData;
    property Color: TAlphaColor read FColor write SetColor;
    property FillColor: TAlphaColor read FFillColor write SetFillColor;
    property WrapMode: TPathWrapMode read FWrapMode write SetWrapMode;
    procedure SaveToStream(s: TStream); override;
    procedure LoadFromStream(s: TStream); override;
    constructor Create; override;
  end;

  TPIMGCoucheImage = class(TPIMGCouche)
  private
    FBitmap: TBitmap;
    FWrapMode: TImageWrapMode;
    procedure SetBitmap(const Value: TBitmap);
    procedure SetWrapMode(const Value: TImageWrapMode);
  public
    property Bitmap: TBitmap read FBitmap write SetBitmap;
    property WrapMode: TImageWrapMode read FWrapMode write SetWrapMode;
    procedure SaveToStream(s: TStream); override;
    procedure LoadFromStream(s: TStream); override;
    constructor Create; override;
    destructor Destroy; override;
  end;

  TPIMGCoucheSVG = class(TPIMGCouche)
  private
    FWrapMode: TSVGImageWrapMode;
    FSVG: string;
    procedure SetSVG(const Value: string);
    procedure SetWrapMode(const Value: TSVGImageWrapMode);
  public
    property SVG: string read FSVG write SetSVG;
    property WrapMode: TSVGImageWrapMode read FWrapMode write SetWrapMode;
    procedure SaveToStream(s: TStream); override;
    procedure LoadFromStream(s: TStream); override;
    constructor Create; override;
  end;

  TPIMGCoucheRectangle = class(TPIMGCouche)
  private
    FColor: TAlphaColor;
    FFillColor: TAlphaColor;
    procedure SetColor(const Value: TAlphaColor);
    procedure SetFillColor(const Value: TAlphaColor);
  public
    property Color: TAlphaColor read FColor write SetColor;
    property FillColor: TAlphaColor read FFillColor write SetFillColor;
    procedure SaveToStream(s: TStream); override;
    procedure LoadFromStream(s: TStream); override;
    constructor Create; override;
  end;

  TPIMGCouches = class(TObjectList<TPIMGCouche>)
  public
    procedure SaveToStream(s: TStream);
    procedure LoadFromStream(s: TStream);
    procedure Initialise;
  end;

  TPIMGProject = class
  private
    FFilename: string;
    FCouches: TPIMGCouches;
    FhasChanged: boolean;
    procedure SetFilename(const Value: string);
    procedure SetCouches(const Value: TPIMGCouches);
    procedure SethasChanged(const Value: boolean);
  public
    property Filename: string read FFilename write SetFilename;
    property Couches: TPIMGCouches read FCouches write SetCouches;
    property hasChanged: boolean read FhasChanged write SethasChanged;
    procedure SaveToFile(AFilename: string = '');
    procedure LoadFromFile(AFilename: string = '');
    procedure Initialise;
    constructor Create;
    destructor Destroy; override;
    class function FileExtension: string;
  end;

implementation

uses
  System.sysutils;

{ TPIMGPRoject }

constructor TPIMGProject.Create;
begin
  Couches := TPIMGCouches.Create;
  Initialise;
end;

destructor TPIMGProject.Destroy;
begin
  Couches.Free;
  inherited;
end;

class function TPIMGProject.FileExtension: string;
begin
  result := '.pimg';
end;

procedure TPIMGProject.Initialise;
begin
  FFilename := '';
  FCouches.Initialise;
  FhasChanged := false;
end;

procedure TPIMGProject.LoadFromFile(AFilename: string);
var
  s: tfilestream;
  version: byte;
begin
  if AFilename.isempty and FFilename.isempty then
    raise exception.Create('Please specify a filename.');

  if not AFilename.isempty then
    FFilename := AFilename;

  s := tfilestream.Create(FFilename, fmOpenRead);
  try
    if (s.Read(version, sizeof(version)) <> sizeof(version)) then
      raise exception.Create('File format errore (version).');
    if (version > 0) and (version <= CCurrentFileVersion) then
      Couches.LoadFromStream(s)
    else
      raise exception.Create('File version not supported.');
  finally
    s.Free;
  end;
end;

procedure TPIMGProject.SaveToFile(AFilename: string);
var
  s: tfilestream;
  version: byte;
begin
  if AFilename.isempty and FFilename.isempty then
    raise exception.Create('Please specify a filename.');

  if not AFilename.isempty then
    FFilename := AFilename;

  s := tfilestream.Create(FFilename, fmcreate);
  try
    version := CCurrentFileVersion;
    // Version du fichier de projet traitée par ce programme.
    s.Write(version, sizeof(version));
    Couches.SaveToStream(s);
    FhasChanged := false;
  finally
    s.Free;
  end;
end;

procedure TPIMGProject.SetCouches(const Value: TPIMGCouches);
begin
  FCouches := Value;
end;

procedure TPIMGProject.SetFilename(const Value: string);
begin
  FFilename := Value;
end;

procedure TPIMGProject.SethasChanged(const Value: boolean);
begin
  FhasChanged := Value;
end;

{ TPIMGCouche }

constructor TPIMGCouche.Create;
begin
  FTypeDeCouche := TPIMGCoucheType.Rien;
  FMargeGauche := 0;
  FMargeBasse := 0;
  FMargeDroite := 0;
  FMargeHaute := 0;
end;

procedure TPIMGCouche.LoadFromStream(s: TStream);
var
  version: byte;
begin
  if not assigned(s) then
    raise exception.Create('wrong stream');

  if (s.Read(version, sizeof(version)) <> sizeof(version)) then
    raise exception.Create('File format error (root version).');
  if (version <= CCurrentLayerVersion) then
  begin
    // marge haute
    if (s.Read(FMargeHaute, sizeof(FMargeHaute)) <> sizeof(FMargeHaute)) then
      raise exception.Create('File format error.');
    // marge droite
    if (s.Read(FMargeDroite, sizeof(FMargeDroite)) <> sizeof(FMargeDroite)) then
      raise exception.Create('File format error.');
    // marge basse
    if (s.Read(FMargeBasse, sizeof(FMargeBasse)) <> sizeof(FMargeBasse)) then
      raise exception.Create('File format error.');
    // marge gauche
    if (s.Read(FMargeGauche, sizeof(FMargeGauche)) <> sizeof(FMargeGauche)) then
      raise exception.Create('File format error.');
  end
  else
    raise exception.Create('Wrong project version (root).');
end;

procedure TPIMGCouche.SaveToStream(s: TStream);
var
  version: byte;
begin
  if not assigned(s) then
    raise exception.Create('wrong stream');

  // Version du format de stockage de la couche "root".
  version := CCurrentLayerVersion;
  s.Write(version, sizeof(version));
  // marge haute
  s.Write(FMargeHaute, sizeof(FMargeHaute));
  // marge droite
  s.Write(FMargeDroite, sizeof(FMargeDroite));
  // marge basse
  s.Write(FMargeBasse, sizeof(FMargeBasse));
  // marge gauche
  s.Write(FMargeGauche, sizeof(FMargeGauche));
end;

procedure TPIMGCouche.SetMargeBasse(const Value: byte);
begin
  FMargeBasse := Value;
end;

procedure TPIMGCouche.SetMargeDroite(const Value: byte);
begin
  FMargeDroite := Value;
end;

procedure TPIMGCouche.SetMargeGauche(const Value: byte);
begin
  FMargeGauche := Value;
end;

procedure TPIMGCouche.SetMargeHaute(const Value: byte);
begin
  FMargeHaute := Value;
end;

{ TPIMGCoucheChemin }

constructor TPIMGCoucheChemin.Create;
begin
  inherited;
  FTypeDeCouche := TPIMGCoucheType.Chemin;
  FColor := talphacolors.Black;
  FFillColor := talphacolors.null;
  FPathData := '';
end;

procedure TPIMGCoucheChemin.LoadFromStream(s: TStream);
var
  version: byte;
  LCouleur: cardinal;
  longueur: cardinal;
  i: integer;
  c: char;
  wm: byte;
begin
  if not assigned(s) then
    raise exception.Create('wrong stream');

  if (s.Read(version, sizeof(version)) <> sizeof(version)) then
    raise exception.Create('File format error (path version).');
  if (version <= CCurrentPathVersion) then
  begin
    // couleur du trait
    if (s.Read(LCouleur, sizeof(LCouleur)) <> sizeof(LCouleur)) then
      raise exception.Create('File format error.')
    else
      Color := LCouleur;
    if (version >= 2) then
    begin
      if (s.Read(LCouleur, sizeof(LCouleur)) <> sizeof(LCouleur)) then
        raise exception.Create('File format error.')
      else
        FillColor := LCouleur;
    end
    else
      FillColor := talphacolors.null;
    // longueur du pathdata
    if (s.Read(longueur, sizeof(longueur)) <> sizeof(longueur)) then
      raise exception.Create('File format error.');
    // pathdata
    PathData := '';
    for i := 1 to longueur do
    begin
      s.ReadData(c);
      PathData := PathData + c;
    end;
    if (version >= 3) then
      inherited;
    if (version >= 4) then
    begin
      if (s.Read(wm, sizeof(wm)) <> sizeof(wm)) then
        raise exception.Create('File format error (image wrap mode).');
      FWrapMode := TPathWrapMode(wm);
    end;
  end
  else
    raise exception.Create('Wrong project version (path).');
end;

procedure TPIMGCoucheChemin.SaveToStream(s: TStream);
var
  version: byte;
  TypeCouche: byte;
  LCouleur: cardinal;
  longueur: cardinal;
  i: integer;
  c: char;
  wm: byte;
begin
  if not assigned(s) then
    raise exception.Create('wrong stream');

  // Type de la couche en cours (pour dépilage)
  TypeCouche := ord(FTypeDeCouche);
  s.Write(TypeCouche, sizeof(TypeCouche));
  // Version du format de stockage de la couche "chemin".
  version := CCurrentPathVersion;
  s.Write(version, sizeof(version));
  // couleur du trait
  LCouleur := Color;
  s.Write(LCouleur, sizeof(LCouleur));
  // couleur de remplissage
  LCouleur := FillColor;
  s.Write(LCouleur, sizeof(LCouleur));
  // longueur du pathdata
  longueur := PathData.Length;
  s.Write(longueur, sizeof(longueur));
  // contenu du pathdata
  for i := 1 to longueur do
  begin
    c := PathData.Chars[i - 1];
    s.WriteData(c);
  end;
  // Sauvegarde des données de l'ancêtre
  inherited;
  wm := ord(FWrapMode);
  s.Write(wm, sizeof(wm));
  // Ajouter ici les autres données à traiter localement
end;

procedure TPIMGCoucheChemin.SetColor(const Value: TAlphaColor);
begin
  FColor := Value;
end;

procedure TPIMGCoucheChemin.SetFillColor(const Value: TAlphaColor);
begin
  FFillColor := Value;
end;

procedure TPIMGCoucheChemin.SetPathData(const Value: string);
begin
  FPathData := Value;
end;

procedure TPIMGCoucheChemin.SetWrapMode(const Value: TPathWrapMode);
begin
  FWrapMode := Value;
end;

{ TPIMGCoucheImage }

constructor TPIMGCoucheImage.Create;
begin
  inherited;
  FTypeDeCouche := TPIMGCoucheType.Image;
  FBitmap := TBitmap.Create;
  FWrapMode := TImageWrapMode.Stretch;
end;

destructor TPIMGCoucheImage.Destroy;
begin
  FBitmap.Free;
  inherited;
end;

procedure TPIMGCoucheImage.LoadFromStream(s: TStream);
var
  version: byte;
  TailleBitmap: cardinal;
  ms: tmemorystream;
  wm: byte;
begin
  if not assigned(s) then
    raise exception.Create('wrong stream');

  if (s.Read(version, sizeof(version)) <> sizeof(version)) then
    raise exception.Create('File format error (image version).');
  if (version <= CCurrentImageVersion) then
  begin
    if (s.Read(TailleBitmap, sizeof(TailleBitmap)) <> sizeof(TailleBitmap)) then
      raise exception.Create('File format error (image size).');
    if TailleBitmap > 0 then
    begin
      ms := tmemorystream.Create;
      try
        ms.CopyFrom(s, TailleBitmap);
        ms.Position := 0;
        try
          FBitmap.LoadFromStream(ms);
        except
          // pas bien, je sais, mais pas trop le choix pour les Bitmap vides
          FBitmap.Clear(talphacolors.Black);
        end;
      finally
        ms.Free;
      end;
    end
    else
      FBitmap.Clear(talphacolors.Black);
    if (version >= 3) then
      inherited;
    if (version >= 4) then
    begin
      if (s.Read(wm, sizeof(wm)) <> sizeof(wm)) then
        raise exception.Create('File format error (image wrap mode).');
      FWrapMode := TImageWrapMode(wm);
    end;
  end
  else
    raise exception.Create('Wrong project version (image).');
end;

procedure TPIMGCoucheImage.SaveToStream(s: TStream);
var
  version: byte;
  TypeCouche: byte;
  TailleBitmap: cardinal;
  ms: tmemorystream;
  wm: byte;
begin
  if not assigned(s) then
    raise exception.Create('wrong stream');

  // Type de la couche en cours (pour dépilage)
  TypeCouche := ord(FTypeDeCouche);
  s.Write(TypeCouche, sizeof(TypeCouche));
  // Version du format de stockage de la couche "chemin".
  version := CCurrentImageVersion;
  s.Write(version, sizeof(version));
  // Enregistrement du bitmap
  ms := tmemorystream.Create;
  try
    try
      FBitmap.SaveToStream(ms);
    except
      // plante sur Mac quand Bitmap vide
      // passe sur Windows quand Bitmap vide aussi
    end;
    TailleBitmap := ms.Size;
    ms.Position := 0;
    s.Write(TailleBitmap, sizeof(TailleBitmap));
    if (TailleBitmap > 0) then
      s.CopyFrom(ms);
  finally
    ms.Free;
  end;
  // Sauvegarde des données de l'ancêtre
  inherited;
  wm := ord(FWrapMode);
  s.Write(wm, sizeof(wm));
  // Ajouter ici les autres données à traiter localement
end;

procedure TPIMGCoucheImage.SetBitmap(const Value: TBitmap);
begin
  FBitmap := Value;
end;

procedure TPIMGCoucheImage.SetWrapMode(const Value: TImageWrapMode);
begin
  FWrapMode := Value;
end;

{ TPIMGCoucheRectangle }

constructor TPIMGCoucheRectangle.Create;
begin
  inherited;
  FTypeDeCouche := TPIMGCoucheType.Rectangle;
  FColor := talphacolors.null;
  FFillColor := talphacolors.Black;
end;

procedure TPIMGCoucheRectangle.LoadFromStream(s: TStream);
var
  version: byte;
  LCouleur: cardinal;
begin
  if not assigned(s) then
    raise exception.Create('wrong stream');

  if (s.Read(version, sizeof(version)) <> sizeof(version)) then
    raise exception.Create('File format error (rectangle version).');
  if (version <= CCurrentRectangleVersion) then
  begin
    // couleur du contour
    if (s.Read(LCouleur, sizeof(LCouleur)) <> sizeof(LCouleur)) then
      raise exception.Create('File format error.')
    else
      Color := LCouleur;
    if (version >= 2) then
    begin
      // couleur de remplissage
      if (s.Read(LCouleur, sizeof(LCouleur)) <> sizeof(LCouleur)) then
        raise exception.Create('File format error.')
      else
        FillColor := LCouleur;
    end
    else
      FillColor := talphacolors.null;
    if (version >= 3) then
      inherited;
  end
  else
    raise exception.Create('Wrong project version (rectangle).');
end;

procedure TPIMGCoucheRectangle.SaveToStream(s: TStream);
var
  version: byte;
  TypeCouche: byte;
  LCouleur: cardinal;
begin
  if not assigned(s) then
    raise exception.Create('wrong stream');

  // Type de la couche en cours (pour dépilage)
  TypeCouche := ord(FTypeDeCouche);
  s.Write(TypeCouche, sizeof(TypeCouche));
  // Version du format de stockage de la couche "chemin".
  version := CCurrentRectangleVersion;
  s.Write(version, sizeof(version));
  // couleur de trait
  LCouleur := Color;
  s.Write(LCouleur, sizeof(LCouleur));
  // couleur de remplissage
  LCouleur := FillColor;
  s.Write(LCouleur, sizeof(LCouleur));
  // Sauvegarde des données de l'ancêtre
  inherited;
  // Ajouter ici les autres données à traiter localement
end;

procedure TPIMGCoucheRectangle.SetColor(const Value: TAlphaColor);
begin
  FColor := Value;
end;

procedure TPIMGCoucheRectangle.SetFillColor(const Value: TAlphaColor);
begin
  FFillColor := Value;
end;

{ TPIMGCouches }

procedure TPIMGCouches.Initialise;
begin
  Clear;
end;

procedure TPIMGCouches.LoadFromStream(s: TStream);
var
  version: byte;
  nb: cardinal;
  TypeCouche: byte;
  i: integer;
  couche: TPIMGCouche;
begin
  if not assigned(s) then
    raise exception.Create('wrong stream');

  if (s.Read(version, sizeof(version)) <> sizeof(version)) then
    raise exception.Create('File format error (version).');
  if (version <= CCurrentLayerListVersion) then
  begin
    Initialise;
    if (s.Read(nb, sizeof(nb)) <> sizeof(nb)) then
      raise exception.Create('File format error (layer count).');
    for i := 1 to nb do
    begin
      if (s.Read(TypeCouche, sizeof(TypeCouche)) <> sizeof(TypeCouche)) then
        raise exception.Create('File format error (layer type 1).');
      case TPIMGCoucheType(TypeCouche) of
        TPIMGCoucheType.Chemin:
          couche := TPIMGCoucheChemin.Create;
        TPIMGCoucheType.Image:
          couche := TPIMGCoucheImage.Create;
        TPIMGCoucheType.Rectangle:
          couche := TPIMGCoucheRectangle.Create;
        TPIMGCoucheType.SVG:
          couche := TPIMGCoucheSVG.Create;
      else
        raise exception.Create('File format error (layer type 2).');
      end;
      couche.LoadFromStream(s);
      add(couche);
    end;
  end
  else
    raise exception.Create('Wrong project version (layer count).');
end;

procedure TPIMGCouches.SaveToStream(s: TStream);
var
  version: byte;
  nb: cardinal;
  i: integer;
begin
  if not assigned(s) then
    raise exception.Create('wrong stream');

  version := CCurrentLayerListVersion;
  // Version du format de stockage de la liste des couches.
  s.Write(version, sizeof(version));
  nb := Count;
  s.Write(nb, sizeof(nb));
  if (nb > 0) then
    for i := 0 to nb - 1 do
      Items[i].SaveToStream(s);
end;

{ TPIMGCoucheSVG }

constructor TPIMGCoucheSVG.Create;
begin
  inherited;
  FTypeDeCouche := TPIMGCoucheType.SVG;
  FSVG := '';
  FWrapMode := TSVGImageWrapMode.iwFit;
end;

procedure TPIMGCoucheSVG.LoadFromStream(s: TStream);
var
  version: byte;
  Taillesvg: cardinal;
  ms: tstringstream;
  wm: byte;
begin
  if not assigned(s) then
    raise exception.Create('wrong stream');

  if (s.Read(version, sizeof(version)) <> sizeof(version)) then
    raise exception.Create('File format error (image version).');
  if (version <= CCurrentSVGVersion) then
  begin
    if (s.Read(Taillesvg, sizeof(Taillesvg)) <> sizeof(Taillesvg)) then
      raise exception.Create('File format error (SVG source size).');
    if Taillesvg > 0 then
    begin
      ms := tstringstream.Create;
      try
        ms.CopyFrom(s, Taillesvg);
        ms.Position := 0;
        FSVG := ms.DataString;
      finally
        ms.Free;
      end;
    end;
    if (s.Read(wm, sizeof(wm)) <> sizeof(wm)) then
      raise exception.Create('File format error (SVG wrap mode).');
    FWrapMode := TSVGImageWrapMode(wm);
    inherited;
  end
  else
    raise exception.Create('Wrong project version (image).');
end;

procedure TPIMGCoucheSVG.SaveToStream(s: TStream);
var
  version: byte;
  TypeCouche: byte;
  Taillesvg: cardinal;
  ms: tstringstream;
  wm: byte;
begin
  if not assigned(s) then
    raise exception.Create('wrong stream');

  // Type de la couche en cours (pour dépilage)
  TypeCouche := ord(FTypeDeCouche);
  s.Write(TypeCouche, sizeof(TypeCouche));
  // Version du format de stockage de la couche "chemin".
  version := CCurrentSVGVersion;
  s.Write(version, sizeof(version));
  // Enregistrement du source du SVG
  ms := tstringstream.Create(FSVG);
  try
    Taillesvg := ms.Size;
    ms.Position := 0;
    s.Write(Taillesvg, sizeof(Taillesvg));
    if (Taillesvg > 0) then
      s.CopyFrom(ms);
  finally
    ms.Free;
  end;
  wm := ord(FWrapMode);
  s.Write(wm, sizeof(wm));
  // Sauvegarde des données de l'ancêtre
  inherited;
  // Ajouter ici les autres données à traiter localement
end;

procedure TPIMGCoucheSVG.SetSVG(const Value: string);
begin
  FSVG := Value;
end;

procedure TPIMGCoucheSVG.SetWrapMode(const Value: TSVGImageWrapMode);
begin
  FWrapMode := Value;
end;

end.
