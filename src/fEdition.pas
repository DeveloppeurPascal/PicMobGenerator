unit fEdition;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  uProjetPIMG, FMX.Layouts, FMX.Controls.Presentation, FMX.Objects,
  FMX.Memo.Types, FMX.ListBox, FMX.Colors, FMX.ScrollBox, FMX.Memo, FMX.Edit,
  FMX.EditBox, FMX.NumberBox, FMX.RS.SVGCtrls;

type
  TfrmEdition = class(TFrame)
    zoneEdition: TLayout;
    btnAddPath: TButton;
    btnAddImage: TButton;
    btnAddRectangle: TButton;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    zoneCouches: TScrollBox;
    zoneProprietes: TScrollBox;
    zonePreviewImages: TScrollBox;
    zonePreviewImagesListe: TFlowLayout;
    ProprietesChemin: TLayout;
    lblProprietesCheminPathData: TLabel;
    mmoCheminPathData: TMemo;
    lblProprietesCheminColor: TLabel;
    ccbCheminColor: TComboColorBox;
    lblProprietesCheminFillColor: TLabel;
    ccbCheminFillColor: TComboColorBox;
    ProprietesRectangle: TLayout;
    lblProprietesRectangleColor: TLabel;
    ccbRectangleColor: TComboColorBox;
    lblProprietesRectangleFillColor: TLabel;
    ccbRectangleFillColor: TComboColorBox;
    ProprietesImage: TLayout;
    lblProprietesImageBitmap: TLabel;
    btnImageCharger: TButton;
    btnImageEffacer: TButton;
    OpenDialogImage: TOpenDialog;
    zonePreview: TLayout;
    zonePreviewTailles: TScrollBox;
    zonePreviewTaillesListe: TFlowLayout;
    btnPreviewToutesTailles: TButton;
    btnPreviewAucuneTaille: TButton;
    FlowLayoutBreak1: TFlowLayoutBreak;
    ProprietesMarges: TLayout;
    lblProprietesMarges: TLabel;
    nbMargeHaute: TNumberBox;
    nbMargeDroite: TNumberBox;
    nbMargeBas: TNumberBox;
    nbMargeGauche: TNumberBox;
    gplProprietesMarges: TGridPanelLayout;
    Layout1: TLayout;
    Layout2: TLayout;
    Layout3: TLayout;
    Layout4: TLayout;
    Layout5: TLayout;
    lblProprietesImageWrapMode: TLabel;
    cbImageWrapMode: TComboBox;
    lblProprietesCheminWrapMode: TLabel;
    cbCheminWrapMode: TComboBox;
    btnPreviewRefresh: TButton;
    gplManipulationsCouches: TGridPanelLayout;
    btnMonterCouche: TButton;
    btnDescendreCouche: TButton;
    btnSupprimerCouche: TButton;
    btnAfficherMasquerCouche: TButton;
    CheminMonterCouche: TPath;
    CheminSupprimerCouche: TPath;
    cheminDescendreCouche: TPath;
    CheminAfficherCouche: TPath;
    CheminMasquerCouche: TPath;
    CheminAddImage: TPath;
    CheminAddPath: TPath;
    CheminAddRectangle: TPath;
    ProprietesSVG: TLayout;
    lblProprietesSVGLibelle: TLabel;
    btnSVGCharger: TButton;
    btnEVGEffacer: TButton;
    lblProprietesSVGWrapMode: TLabel;
    cbSVGWrapMode: TComboBox;
    OpenDialogSVG: TOpenDialog;
    zoneToolbar: THorzScrollBox;
    btnAddSVG: TButton;
    CheminAddSVG: TPath;
    rBackground: TRectangle;
    procedure btnAddPathClick(Sender: TObject);
    procedure btnAddImageClick(Sender: TObject);
    procedure btnAddRectangleClick(Sender: TObject);
    procedure mmoCheminPathDataChange(Sender: TObject);
    procedure ccbCheminColorChange(Sender: TObject);
    procedure ccbCheminFillColorChange(Sender: TObject);
    procedure ccbRectangleColorChange(Sender: TObject);
    procedure ccbRectangleFillColorChange(Sender: TObject);
    procedure btnImageEffacerClick(Sender: TObject);
    procedure btnImageChargerClick(Sender: TObject);
    procedure btnPreviewToutesTaillesClick(Sender: TObject);
    procedure btnPreviewAucuneTailleClick(Sender: TObject);
    procedure zonePreviewTaillesListeResized(Sender: TObject);
    procedure zonePreviewImagesListeResized(Sender: TObject);
    procedure nbMargeBasChange(Sender: TObject);
    procedure nbMargeDroiteChange(Sender: TObject);
    procedure nbMargeGaucheChange(Sender: TObject);
    procedure nbMargeHauteChange(Sender: TObject);
    procedure cbImageWrapModeChange(Sender: TObject);
    procedure cbCheminWrapModeChange(Sender: TObject);
    procedure btnPreviewRefreshClick(Sender: TObject);
    procedure btnSupprimerCoucheClick(Sender: TObject);
    procedure btnMonterCoucheClick(Sender: TObject);
    procedure btnDescendreCoucheClick(Sender: TObject);
    procedure btnSVGChargerClick(Sender: TObject);
    procedure btnSVGEffacerClick(Sender: TObject);
    procedure cbSVGWrapModeChange(Sender: TObject);
    procedure btnAddSVGClick(Sender: TObject);
  private
    class var maframe: TfrmEdition;

  var
    FCoucheActiveALEcran: TRectangle;
    procedure SetCoucheActiveALEcran(const Value: TRectangle);

  var
    FProjetOuvert: TPIMGProject;
    procedure SetProjetOuvert(const Value: TPIMGProject);
  protected
    function AjouteCouche(ATypeCouche: TPIMGCoucheType;
      ACouche: TPIMGCouche = nil): TRectangle;
    procedure ActiveCouche(CoucheALEcran: TRectangle);
    procedure ClickSurCouche(Sender: TObject);
    procedure AfficheProprietes(CoucheAGerer: TRectangle);
    function getCoucheFromObject(FMXObject: TFMXObject): TPIMGCouche;
    function getRectangleFromObject(FMXObject: TFMXObject): TRectangle;
    procedure InitialiseTaillesListe;
    procedure InitialisePreviewImagesList;
    procedure PreviewTailleChange(Sender: TObject);
    procedure CalculeHauteurFlowLayout(fl: TFlowLayout);
    function getNewChemin(ACouche: TPIMGCoucheChemin; AParent: TFMXObject;
      ImageFinale: boolean = false; largeur: integer = 0; hauteur: integer = 0)
      : FMX.Objects.TPath;
    function getNewImage(ACouche: TPIMGCoucheImage; AParent: TFMXObject;
      ImageFinale: boolean = false; largeur: integer = 0;
      hauteur: integer = 0): timage;
    function getNewRectangle(ACouche: TPIMGCoucheRectangle; AParent: TFMXObject;
      ImageFinale: boolean = false; largeur: integer = 0; hauteur: integer = 0)
      : TRectangle;
    function getNewSVG(ACouche: TPIMGCoucheSVG; AParent: TFMXObject;
      ImageFinale: boolean = false; largeur: integer = 0; hauteur: integer = 0)
      : TRSSVGImage;
  public
    property CoucheActiveALEcran: TRectangle read FCoucheActiveALEcran
      write SetCoucheActiveALEcran;
    property ProjetOuvert: TPIMGProject read FProjetOuvert
      write SetProjetOuvert;
    procedure Hide; override;
    class function getCurrent: TfrmEdition;
    constructor Create(AOwner: TComponent); override;
    function GenereImage(largeur, hauteur: integer): TLayout;
  end;

implementation

{$R *.fmx}

uses System.ioutils, uDM, System.TypInfo, FMX.RS.SVGTypes;

const
  CMarge = 10;

type
  TMyRSFmxSVGDocument = class(TRSFmxSVGDocument)
  private
    FCoucheSVG: TPIMGCoucheSVG;
    procedure SetCoucheSVG(const Value: TPIMGCoucheSVG);
  public
    property CoucheSVG: TPIMGCoucheSVG read FCoucheSVG write SetCoucheSVG;
  end;

  { TfrmEdition }

procedure TfrmEdition.ActiveCouche(CoucheALEcran: TRectangle);
begin
  if assigned(getCoucheFromObject(CoucheALEcran)) then
    CoucheActiveALEcran := CoucheALEcran;
end;

procedure TfrmEdition.AfficheProprietes(CoucheAGerer: TRectangle);
var
  i: integer;
  couche: TPIMGCouche;
begin
  // Masquage des propriétés existantes
  for i := 0 to zoneProprietes.Content.ChildrenCount - 1 do
    if (zoneProprietes.Content.Children[i] is TLayout) then
      (zoneProprietes.Content.Children[i] as TLayout).Visible := false;

  if not assigned(CoucheAGerer) then
    exit;

  // Affichage des propriétés associées à l'élément sélectionné
  couche := getCoucheFromObject(CoucheAGerer);
  if assigned(couche) then
    case couche.TypeDeCouche of
      TPIMGCoucheType.Chemin:
        begin
          ProprietesChemin.Visible := true;
          ProprietesChemin.TagObject := CoucheAGerer;
          mmoCheminPathData.Lines.Text := (couche as TPIMGCoucheChemin)
            .PathData;
          ccbCheminColor.Color := (couche as TPIMGCoucheChemin).Color;
          ccbCheminFillColor.Color := (couche as TPIMGCoucheChemin).FillColor;
          for i := 0 to cbCheminWrapMode.items.Count - 1 do
            if cbCheminWrapMode.ListItems[i].Tag = ord
              ((couche as TPIMGCoucheChemin).WrapMode) then
              cbCheminWrapMode.ItemIndex := i;
        end;
      TPIMGCoucheType.Rectangle:
        begin
          ProprietesRectangle.Visible := true;
          ProprietesRectangle.TagObject := CoucheAGerer;
          ccbRectangleColor.Color := (couche as TPIMGCoucheRectangle).Color;
          ccbRectangleFillColor.Color := (couche as TPIMGCoucheRectangle)
            .FillColor;
        end;
      TPIMGCoucheType.Image:
        begin
          ProprietesImage.Visible := true;
          ProprietesImage.TagObject := CoucheAGerer;
          for i := 0 to cbImageWrapMode.items.Count - 1 do
            if cbImageWrapMode.ListItems[i].Tag = ord
              ((couche as TPIMGCoucheImage).WrapMode) then
              cbImageWrapMode.ItemIndex := i;
        end;
      TPIMGCoucheType.SVG:
        begin
          ProprietesSVG.Visible := true;
          ProprietesSVG.TagObject := CoucheAGerer;
          for i := 0 to cbSVGWrapMode.items.Count - 1 do
            if cbSVGWrapMode.ListItems[i].Tag = ord((couche as TPIMGCoucheSVG)
              .WrapMode) then
              cbSVGWrapMode.ItemIndex := i;
        end;
    else
      raise exception.Create
        ('Property editor not available for this layer type.');
    end;
  ProprietesMarges.Visible := true;
  ProprietesMarges.TagObject := CoucheAGerer;
  nbMargeHaute.Value := couche.MargeHaute;
  nbMargeDroite.Value := couche.MargeDroite;
  nbMargeBas.Value := couche.MargeBasse;
  nbMargeGauche.Value := couche.MargeGauche;
end;

function TfrmEdition.AjouteCouche(ATypeCouche: TPIMGCoucheType;
  ACouche: TPIMGCouche): TRectangle;
var
  r: TRectangle;
  cp: FMX.Objects.TPath;
  ci: timage;
  csvg: TRSSVGImage;
  cr: TRectangle;
  i: integer;
  couche: TPIMGCouche;
begin
  // Si pas de couche passée en paramètre, on la crée vierge
  if not assigned(ACouche) then
  begin
    case ATypeCouche of
      TPIMGCoucheType.Chemin:
        couche := TPIMGCoucheChemin.Create;
      TPIMGCoucheType.Image:
        couche := TPIMGCoucheImage.Create;
      TPIMGCoucheType.Rectangle:
        couche := TPIMGCoucheRectangle.Create;
      TPIMGCoucheType.SVG:
        couche := TPIMGCoucheSVG.Create;
    else
      raise exception.Create('Layer type not implemented');
    end;
    ProjetOuvert.Couches.Add(couche);
    ProjetOuvert.hasChanged := true;
  end
  else
    couche := ACouche;

  // Création "tuile" de la couche dans la liste des couches à l'écran
  r := TRectangle.Create(self);
  r.Parent := zoneCouches;
  r.Position.x := CMarge;
  r.Position.Y := CMarge;
  r.width := zoneCouches.width - CMarge * 2 - 20;
  // en supposant 20px=largeur ascenseur
  r.Height := r.width;
  r.XRadius := 5;
  r.YRadius := 5;
  r.Padding.Top := 5;
  r.Padding.right := 5;
  r.Padding.left := 5;
  r.Padding.bottom := 5;
  r.HitTest := true;
  r.OnClick := ClickSurCouche;
  r.TagObject := couche;
  result := r;

  // Décalage des couches existantes pour afficher l'actuelle en haut
  for i := 0 to zoneCouches.Content.ChildrenCount - 1 do
    if (zoneCouches.Content.Children[i] is TRectangle) and
      (r <> zoneCouches.Content.Children[i]) then
      (zoneCouches.Content.Children[i] as TRectangle).Position.Y :=
        (zoneCouches.Content.Children[i] as TRectangle).Position.Y + r.Height +
        2 * CMarge;

  // Paramétrage du type de couche sur l'affichage à l'écran
  case ATypeCouche of
    TPIMGCoucheType.Chemin:
      begin
        cp := getNewChemin(couche as TPIMGCoucheChemin, r);
        cp.Align := TAlignLayout.Client;
        cp.HitTest := false;
      end;
    TPIMGCoucheType.Image:
      begin
        ci := getNewImage(couche as TPIMGCoucheImage, r);
        ci.Align := TAlignLayout.Client;
        ci.HitTest := false;
      end;
    TPIMGCoucheType.Rectangle:
      begin
        cr := getNewRectangle(couche as TPIMGCoucheRectangle, r);
        cr.Align := TAlignLayout.Client;
        cr.HitTest := false;
      end;
    TPIMGCoucheType.SVG:
      begin
        csvg := getNewSVG(couche as TPIMGCoucheSVG, r);
        csvg.Align := TAlignLayout.Client;
        csvg.HitTest := false;
      end;
  else
    raise exception.Create('Layer type not implemented');
  end;
end;

procedure TfrmEdition.btnAddImageClick(Sender: TObject);
begin
  ActiveCouche(AjouteCouche(TPIMGCoucheType.Image));
end;

procedure TfrmEdition.btnAddPathClick(Sender: TObject);
begin
  ActiveCouche(AjouteCouche(TPIMGCoucheType.Chemin));
end;

procedure TfrmEdition.btnAddRectangleClick(Sender: TObject);
begin
  ActiveCouche(AjouteCouche(TPIMGCoucheType.Rectangle));
end;

procedure TfrmEdition.btnAddSVGClick(Sender: TObject);
begin
  ActiveCouche(AjouteCouche(TPIMGCoucheType.SVG));
end;

procedure TfrmEdition.btnDescendreCoucheClick(Sender: TObject);
var
  Rectangle, RectangleASwapper: TRectangle;
  Y: single;
  couche: TPIMGCouche;
  i: integer;
begin
  Rectangle := getRectangleFromObject(ProprietesMarges);
  couche := getCoucheFromObject(Rectangle);
  if assigned(couche) then
  begin
    // Trouver la couche à inverser par rapport à l'actuelle qu'on monte d'un cran
    Y := zoneCouches.Content.ScrollBox.ContentBounds.Height;
    RectangleASwapper := nil;
    for i := 0 to zoneCouches.Content.ChildrenCount - 1 do
      if (zoneCouches.Content.Children[i] is TRectangle) and
        ((zoneCouches.Content.Children[i] as TRectangle).Position.Y <= Y) and
        ((zoneCouches.Content.Children[i] as TRectangle).Position.Y >
        Rectangle.Position.Y) then
      begin
        RectangleASwapper := (zoneCouches.Content.Children[i] as TRectangle);
        Y := RectangleASwapper.Position.Y;
      end;
    if assigned(RectangleASwapper) then
    begin
      // on a un rectangle, on inverse les deux
      RectangleASwapper.Position.Y := Rectangle.Position.Y;
      Rectangle.Position.Y := RectangleASwapper.Position.Y +
        RectangleASwapper.Height + 2 * CMarge;
      // On fait l'inversion dans la liste
      i := ProjetOuvert.Couches.IndexOf(couche);
      if (i >= 0) then
      begin
        ProjetOuvert.Couches.Extract(couche);
        ProjetOuvert.Couches.Insert(i - 1, couche);
      end;
      // Le projet a été modifié
      ProjetOuvert.hasChanged := true;
    end;
  end;
end;

procedure TfrmEdition.btnSVGEffacerClick(Sender: TObject);
var
  Rectangle: TRectangle;
  couche: TPIMGCouche;
  i: integer;
begin
  Rectangle := getRectangleFromObject(ProprietesSVG);
  couche := getCoucheFromObject(Rectangle);
  if assigned(couche) and (couche is TPIMGCoucheSVG) then
  begin
    (couche as TPIMGCoucheSVG).SVG := '';
    ProjetOuvert.hasChanged := true;
    for i := 0 to Rectangle.componentCount - 1 do
      if (Rectangle.components[i] is TMyRSFmxSVGDocument) and
        ((Rectangle.components[i] as TMyRSFmxSVGDocument).CoucheSVG = couche)
      then
        (Rectangle.components[i] as TMyRSFmxSVGDocument).Lines.Clear;
    for i := 0 to Rectangle.componentCount - 1 do
      if (Rectangle.components[i] is TRSSVGImage) then
        (Rectangle.components[i] as TRSSVGImage).Visible := false;
  end;
end;

procedure TfrmEdition.btnImageChargerClick(Sender: TObject);
var
  Rectangle: TRectangle;
  couche: TPIMGCouche;
  NomFichier: string;
begin
  Rectangle := getRectangleFromObject(ProprietesImage);
  couche := getCoucheFromObject(Rectangle);
  OpenDialogImage.InitialDir := System.ioutils.TPath.GetPicturesPath;
  // TODO : remettre le dernier chemin utilisé (s'il existe)
  if assigned(couche) and (couche is TPIMGCoucheImage) and OpenDialogImage.Execute
  then
  begin
    NomFichier := trim(OpenDialogImage.FileName);
    if (not NomFichier.IsEmpty) and tfile.Exists(NomFichier) then
    begin
      // TODO : Enregistrer le dernier chemin utilisé
      try
        (couche as TPIMGCoucheImage).Bitmap.LoadFromFile(NomFichier);
        ProjetOuvert.hasChanged := true;
        if (Rectangle.Children[0] is timage) then
          (Rectangle.Children[0] as timage)
            .Bitmap.Assign((couche as TPIMGCoucheImage).Bitmap);
      except
        btnImageEffacerClick(Sender);
      end;
    end;
  end;
end;

procedure TfrmEdition.btnImageEffacerClick(Sender: TObject);
var
  Rectangle: TRectangle;
  couche: TPIMGCouche;
begin
  Rectangle := getRectangleFromObject(ProprietesImage);
  couche := getCoucheFromObject(Rectangle);
  if assigned(couche) and (couche is TPIMGCoucheImage) then
  begin
    (couche as TPIMGCoucheImage).Bitmap.SetSize(0, 0);
    ProjetOuvert.hasChanged := true;
    if (Rectangle.Children[0] is timage) then
      (Rectangle.Children[0] as timage).Bitmap.SetSize(0, 0);
  end;
end;

procedure TfrmEdition.btnMonterCoucheClick(Sender: TObject);
var
  Rectangle, RectangleASwapper: TRectangle;
  Y: single;
  couche: TPIMGCouche;
  i: integer;
begin
  Rectangle := getRectangleFromObject(ProprietesMarges);
  couche := getCoucheFromObject(Rectangle);
  if assigned(couche) then
  begin
    // Trouver la couche à inverser par rapport à l'actuelle qu'on monte d'un cran
    Y := 0;
    RectangleASwapper := nil;
    for i := 0 to zoneCouches.Content.ChildrenCount - 1 do
      if (zoneCouches.Content.Children[i] is TRectangle) and
        ((zoneCouches.Content.Children[i] as TRectangle).Position.Y >= Y) and
        ((zoneCouches.Content.Children[i] as TRectangle).Position.Y <
        Rectangle.Position.Y) then
      begin
        RectangleASwapper := (zoneCouches.Content.Children[i] as TRectangle);
        Y := RectangleASwapper.Position.Y;
      end;
    if assigned(RectangleASwapper) then
    begin
      // on a un rectangle, on inverse les deux
      Rectangle.Position.Y := RectangleASwapper.Position.Y;
      RectangleASwapper.Position.Y := Rectangle.Position.Y + Rectangle.Height +
        2 * CMarge;
      // On fait l'inversion dans la liste
      i := ProjetOuvert.Couches.IndexOf(couche);
      if (i >= 0) then
      begin
        ProjetOuvert.Couches.Extract(couche);
        ProjetOuvert.Couches.Insert(i + 1, couche);
      end;
      // Le projet a été modifié
      ProjetOuvert.hasChanged := true;
    end;
  end;
end;

procedure TfrmEdition.btnPreviewAucuneTailleClick(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to zonePreviewTaillesListe.ChildrenCount - 1 do
    if (zonePreviewTaillesListe.Children[i] is tcheckbox) then
      (zonePreviewTaillesListe.Children[i] as tcheckbox).IsChecked := false;
end;

procedure TfrmEdition.btnPreviewRefreshClick(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to zonePreviewTaillesListe.ChildrenCount - 1 do
    if (zonePreviewTaillesListe.Children[i] is tcheckbox) and
      (zonePreviewTaillesListe.Children[i] as tcheckbox).IsChecked then
    begin
      (zonePreviewTaillesListe.Children[i] as tcheckbox).IsChecked := false;
      (zonePreviewTaillesListe.Children[i] as tcheckbox).IsChecked := true;
    end;
end;

procedure TfrmEdition.btnPreviewToutesTaillesClick(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to zonePreviewTaillesListe.ChildrenCount - 1 do
    if (zonePreviewTaillesListe.Children[i] is tcheckbox) then
      (zonePreviewTaillesListe.Children[i] as tcheckbox).IsChecked := true;
end;

procedure TfrmEdition.btnSupprimerCoucheClick(Sender: TObject);
var
  Rectangle: TRectangle;
  couche: TPIMGCouche;
  Rect_Y, Rect_Height: single;
  i: integer;
begin
  Rectangle := getRectangleFromObject(ProprietesMarges);
  couche := getCoucheFromObject(Rectangle);
  if assigned(couche) then
  begin
    // Manipulation des blocs dans la liste des couches
    Rect_Y := Rectangle.Position.Y;
    Rect_Height := Rectangle.Height;
    // pour MacOS/iOS : la suppression du rectangle génère un plantage
    // (accès zone mzmoire protégée ou un truc comme ça)
    // donc on contourne le problème en masquant la zone et en repoussant sa
    // suppression au ProcessMessage suivant (une fois sortis de cet événement)
    Rectangle.Visible := false;
    tthread.ForceQueue(nil,
      procedure
      begin
        Rectangle.free;
      end);
    // Fin bidouille Mac/iOS
    // "Rectangle.free;" suffit sur les autres plateformes
    for i := 0 to zoneCouches.Content.ChildrenCount - 1 do
      if (zoneCouches.Content.Children[i] is TRectangle) and
        ((zoneCouches.Content.Children[i] as TRectangle).Position.Y > Rect_Y)
      then
        (zoneCouches.Content.Children[i] as TRectangle).Position.Y :=
          (zoneCouches.Content.Children[i] as TRectangle).Position.Y -
          Rect_Height - 2 * CMarge;
    // Suppression de la couche dans la liste du projet
    if (ProjetOuvert.Couches.Remove(couche) < 0) then
      raise exception.Create
        ('Suppression de la couche non effectuée dans la liste.');
    // Le projet a été modifié
    ProjetOuvert.hasChanged := true;
    CoucheActiveALEcran := nil;
  end;
end;

procedure TfrmEdition.btnSVGChargerClick(Sender: TObject);
var
  Rectangle: TRectangle;
  couche: TPIMGCouche;
  NomFichier: string;
  i: integer;
begin
  Rectangle := getRectangleFromObject(ProprietesSVG);
  couche := getCoucheFromObject(Rectangle);
  OpenDialogImage.InitialDir := System.ioutils.TPath.GetPicturesPath;
  // TODO : remettre le dernier chemin utilisé (s'il existe)
  if assigned(couche) and (couche is TPIMGCoucheSVG) and OpenDialogSVG.Execute
  then
  begin
    NomFichier := trim(OpenDialogSVG.FileName);
    if (not NomFichier.IsEmpty) and tfile.Exists(NomFichier) then
    begin
      // TODO : Enregistrer le dernier chemin utilisé
      try
        (couche as TPIMGCoucheSVG).SVG := tfile.ReadAllText(NomFichier);
        if (couche as TPIMGCoucheSVG).SVG.IsEmpty then
          btnSVGEffacerClick(Sender)
        else
        begin
          ProjetOuvert.hasChanged := true;
          for i := 0 to Rectangle.componentCount - 1 do
            if (Rectangle.components[i] is TMyRSFmxSVGDocument) and
              ((Rectangle.components[i] as TMyRSFmxSVGDocument)
              .CoucheSVG = couche) then
            begin
              (Rectangle.components[i] as TMyRSFmxSVGDocument).Lines.Clear;
              (Rectangle.components[i] as TMyRSFmxSVGDocument)
                .Lines.Add((couche as TPIMGCoucheSVG).SVG);
            end;
          for i := 0 to Rectangle.componentCount - 1 do
            if (Rectangle.components[i] is TRSSVGImage) then
              (Rectangle.components[i] as TRSSVGImage).Visible := true;
        end;
      except
        btnSVGEffacerClick(Sender);
      end;
    end;
  end;
end;

procedure TfrmEdition.CalculeHauteurFlowLayout(fl: TFlowLayout);
var
  hauteur_fl, hauteur_children: single;
  i: integer;
  ctrl: tcontrol;
begin
  if not assigned(fl) then
    exit;

  hauteur_fl := 0;
  for i := 0 to fl.ChildrenCount - 1 do
    if (fl.Children[i] is tcontrol) then
    begin
      ctrl := (fl.Children[i] as tcontrol);
      hauteur_children := ctrl.Position.Y + ctrl.Height + ctrl.Margins.bottom;
      if hauteur_fl < hauteur_children then
        hauteur_fl := hauteur_children;
    end;
  fl.Height := hauteur_fl;
end;

procedure TfrmEdition.cbCheminWrapModeChange(Sender: TObject);
var
  Rectangle: TRectangle;
  couche: TPIMGCouche;
begin
  Rectangle := getRectangleFromObject(ProprietesChemin);
  couche := getCoucheFromObject(Rectangle);
  if assigned(couche) and (couche is TPIMGCoucheChemin) then
  begin
    (couche as TPIMGCoucheChemin).WrapMode :=
      tpathwrapmode(cbCheminWrapMode.Selected.Tag);
    ProjetOuvert.hasChanged := true;
  end;
end;

procedure TfrmEdition.cbImageWrapModeChange(Sender: TObject);
var
  Rectangle: TRectangle;
  couche: TPIMGCouche;
begin
  Rectangle := getRectangleFromObject(ProprietesImage);
  couche := getCoucheFromObject(Rectangle);
  if assigned(couche) and (couche is TPIMGCoucheImage) then
  begin
    (couche as TPIMGCoucheImage).WrapMode :=
      timagewrapmode(cbImageWrapMode.Selected.Tag);
    ProjetOuvert.hasChanged := true;
  end;
end;

procedure TfrmEdition.cbSVGWrapModeChange(Sender: TObject);
var
  Rectangle: TRectangle;
  couche: TPIMGCouche;
begin
  Rectangle := getRectangleFromObject(ProprietesSVG);
  couche := getCoucheFromObject(Rectangle);
  if assigned(couche) and (couche is TPIMGCoucheSVG) then
  begin
    (couche as TPIMGCoucheSVG).WrapMode :=
      tsvgimagewrapmode(cbSVGWrapMode.Selected.Tag);
    ProjetOuvert.hasChanged := true;
  end;
end;

procedure TfrmEdition.ccbCheminColorChange(Sender: TObject);
var
  Rectangle: TRectangle;
  couche: TPIMGCouche;
begin
  Rectangle := getRectangleFromObject(ProprietesChemin);
  couche := getCoucheFromObject(Rectangle);
  if assigned(couche) and (couche is TPIMGCoucheChemin) then
  begin
    (couche as TPIMGCoucheChemin).Color := ccbCheminColor.Color;
    ProjetOuvert.hasChanged := true;
    if (Rectangle.Children[0] is FMX.Objects.TPath) then
      (Rectangle.Children[0] as FMX.Objects.TPath).Stroke.Color :=
        ccbCheminColor.Color;
  end;
end;

procedure TfrmEdition.ccbCheminFillColorChange(Sender: TObject);
var
  Rectangle: TRectangle;
  couche: TPIMGCouche;
begin
  Rectangle := getRectangleFromObject(ProprietesChemin);
  couche := getCoucheFromObject(Rectangle);
  if assigned(couche) and (couche is TPIMGCoucheChemin) then
  begin
    (couche as TPIMGCoucheChemin).FillColor := ccbCheminFillColor.Color;
    ProjetOuvert.hasChanged := true;
    if (Rectangle.Children[0] is FMX.Objects.TPath) then
      (Rectangle.Children[0] as FMX.Objects.TPath).Fill.Color :=
        ccbCheminFillColor.Color;
  end;
end;

procedure TfrmEdition.ccbRectangleColorChange(Sender: TObject);
var
  Rectangle: TRectangle;
  couche: TPIMGCouche;
begin
  Rectangle := getRectangleFromObject(ProprietesRectangle);
  couche := getCoucheFromObject(Rectangle);
  if assigned(couche) and (couche is TPIMGCoucheRectangle) then
  begin
    (couche as TPIMGCoucheRectangle).Color := ccbRectangleColor.Color;
    ProjetOuvert.hasChanged := true;
    if (Rectangle.Children[0] is TRectangle) then
      (Rectangle.Children[0] as TRectangle).Stroke.Color :=
        ccbRectangleColor.Color;
  end;
end;

procedure TfrmEdition.ccbRectangleFillColorChange(Sender: TObject);
var
  Rectangle: TRectangle;
  couche: TPIMGCouche;
begin
  Rectangle := getRectangleFromObject(ProprietesRectangle);
  couche := getCoucheFromObject(Rectangle);
  if assigned(couche) and (couche is TPIMGCoucheRectangle) then
  begin
    (couche as TPIMGCoucheRectangle).FillColor := ccbRectangleFillColor.Color;
    ProjetOuvert.hasChanged := true;
    if (Rectangle.Children[0] is TRectangle) then
      (Rectangle.Children[0] as TRectangle).Fill.Color :=
        ccbRectangleFillColor.Color;
  end;
end;

procedure TfrmEdition.ClickSurCouche(Sender: TObject);
begin
  if (Sender is TRectangle) then
    ActiveCouche(Sender as TRectangle);
end;

constructor TfrmEdition.Create(AOwner: TComponent);
var
  iwm: timagewrapmode;
  pwm: tpathwrapmode;
  svgwm: tsvgimagewrapmode;
begin
  inherited;
  Name := '';

  InitialiseTaillesListe;

  InitialisePreviewImagesList;

  // Liste des WrapMode utilisables sur les images dans cette version de Delphi / FMX
  cbImageWrapMode.items.Clear;
  for iwm := low(timagewrapmode) to high(timagewrapmode) do
    cbImageWrapMode.ListItems
      [cbImageWrapMode.items.Add(GetEnumName(typeinfo(timagewrapmode), ord(iwm))
      )].Tag := ord(iwm);

  // Liste des WrapMode utilisables sur les TPath (chemin SVG) dans cette version de Delphi / FMX
  cbCheminWrapMode.items.Clear;
  for pwm := low(tpathwrapmode) to high(tpathwrapmode) do
    cbCheminWrapMode.ListItems
      [cbCheminWrapMode.items.Add(GetEnumName(typeinfo(tpathwrapmode), ord(pwm))
      )].Tag := ord(pwm);

  // Liste des WrapMode utilisables sur les TRSSVGImage (fichier SVG) depuis la librairie RiverSoft AVG:
  // http://www.riversoftavg.com/svg.htm
  cbSVGWrapMode.items.Clear;
  for svgwm := low(tsvgimagewrapmode) to high(tsvgimagewrapmode) do
    cbSVGWrapMode.ListItems
      [cbSVGWrapMode.items.Add(GetEnumName(typeinfo(tsvgimagewrapmode),
      ord(svgwm)).Substring(2))].Tag := ord(svgwm);
  // on vire le "iw" de iwCenter....
end;

function TfrmEdition.GenereImage(largeur, hauteur: integer): TLayout;
var
  l: TLayout;
  i: integer;
begin
  if assigned(ProjetOuvert) and assigned(ProjetOuvert.Couches) and
    (ProjetOuvert.Couches.Count > 0) then
    try
      l := TLayout.Create(self);
      try
        l.width := largeur;
        l.Height := hauteur;
        l.ClipChildren := true;
        for i := 0 to ProjetOuvert.Couches.Count - 1 do
          case ProjetOuvert.Couches[i].TypeDeCouche of
            TPIMGCoucheType.Chemin:
              getNewChemin(ProjetOuvert.Couches[i] as TPIMGCoucheChemin, l,
                true, largeur, hauteur);
            TPIMGCoucheType.Image:
              getNewImage(ProjetOuvert.Couches[i] as TPIMGCoucheImage, l, true,
                largeur, hauteur);
            TPIMGCoucheType.Rectangle:
              getNewRectangle(ProjetOuvert.Couches[i] as TPIMGCoucheRectangle,
                l, true, largeur, hauteur);
            TPIMGCoucheType.SVG:
              getNewSVG(ProjetOuvert.Couches[i] as TPIMGCoucheSVG, l, true,
                largeur, hauteur);
          else
            raise exception.Create('Layer type not implemented');
          end;
      finally
        result := l;
      end;
    except
      result := nil;
    end
  else
    result := nil;
end;

function TfrmEdition.getCoucheFromObject(FMXObject: TFMXObject): TPIMGCouche;
begin
  if assigned(FMXObject) and assigned(FMXObject.TagObject) and
    (FMXObject.TagObject is TPIMGCouche) then
    result := FMXObject.TagObject as TPIMGCouche
  else
    result := nil;
end;

class function TfrmEdition.getCurrent: TfrmEdition;
begin
  if not assigned(maframe) then
    maframe := TfrmEdition.Create(nil);
  result := maframe;
end;

function TfrmEdition.getNewChemin(ACouche: TPIMGCoucheChemin;
AParent: TFMXObject; ImageFinale: boolean; largeur: integer; hauteur: integer)
  : FMX.Objects.TPath;
begin
  result := FMX.Objects.TPath.Create(AParent);
  result.Parent := AParent;
  result.Data.Data := ACouche.PathData;
  result.Stroke.Color := ACouche.Color;
  result.Fill.Color := ACouche.FillColor;
  if ImageFinale then
  begin
    // Propriétés gérées uniquement lors de l'export ou la prévisualisation
    result.Align := TAlignLayout.Client;
    result.Margins.Top := ACouche.MargeHaute * hauteur / 100;
    result.Margins.right := ACouche.MargeDroite * largeur / 100;
    result.Margins.bottom := ACouche.MargeBasse * hauteur / 100;
    result.Margins.left := ACouche.MargeGauche * largeur / 100;
    result.WrapMode := ACouche.WrapMode;
  end
  else
  begin
    // Propriétés non prises en charge sur l'export, mais utiles pour l'affichage et le choix des couches à l'écran
  end;
end;

function TfrmEdition.getNewImage(ACouche: TPIMGCoucheImage; AParent: TFMXObject;
ImageFinale: boolean; largeur: integer; hauteur: integer): timage;
begin
  result := timage.Create(AParent);
  result.Parent := AParent;
  result.Bitmap.Assign(ACouche.Bitmap);
  if ImageFinale then
  begin
    // Propriétés gérées uniquement lors de l'export ou la prévisualisation
    result.Align := TAlignLayout.Client;
    result.Margins.Top := ACouche.MargeHaute * hauteur / 100;
    result.Margins.right := ACouche.MargeDroite * largeur / 100;
    result.Margins.bottom := ACouche.MargeBasse * hauteur / 100;
    result.Margins.left := ACouche.MargeGauche * largeur / 100;
    result.WrapMode := ACouche.WrapMode;
  end
  else
  begin
    // Propriétés non prises en charge sur l'export, mais utiles pour l'affichage et le choix des couches à l'écran
  end;
end;

function TfrmEdition.getNewRectangle(ACouche: TPIMGCoucheRectangle;
AParent: TFMXObject; ImageFinale: boolean; largeur: integer; hauteur: integer)
  : TRectangle;
begin
  result := TRectangle.Create(AParent);
  result.Parent := AParent;
  result.Stroke.Kind := tbrushkind.None;
  result.Stroke.Color := ACouche.Color;
  result.Fill.Color := ACouche.FillColor;
  if ImageFinale then
  begin
    // Propriétés gérées uniquement lors de l'export ou la prévisualisation
    result.Align := TAlignLayout.Client;
    result.Margins.Top := ACouche.MargeHaute * hauteur / 100;
    result.Margins.right := ACouche.MargeDroite * largeur / 100;
    result.Margins.bottom := ACouche.MargeBasse * hauteur / 100;
    result.Margins.left := ACouche.MargeGauche * largeur / 100;
  end
  else
  begin
    // Propriétés non prises en charge sur l'export, mais utiles pour l'affichage et le choix des couches à l'écran
  end;
end;

function TfrmEdition.getNewSVG(ACouche: TPIMGCoucheSVG; AParent: TFMXObject;
ImageFinale: boolean; largeur, hauteur: integer): TRSSVGImage;
var
  doc: TMyRSFmxSVGDocument;
begin
  doc := TMyRSFmxSVGDocument.Create(AParent);
  if not ACouche.SVG.IsEmpty then
    doc.Lines.Add(ACouche.SVG);
  doc.CoucheSVG := ACouche;
  result := TRSSVGImage.Create(AParent);
  result.Parent := AParent;
  result.SVGDocument := doc;
  if ImageFinale then
  begin
    // Propriétés gérées uniquement lors de l'export ou la prévisualisation
    result.Align := TAlignLayout.Client;
    result.Margins.Top := ACouche.MargeHaute * hauteur / 100;
    result.Margins.right := ACouche.MargeDroite * largeur / 100;
    result.Margins.bottom := ACouche.MargeBasse * hauteur / 100;
    result.Margins.left := ACouche.MargeGauche * largeur / 100;
    result.WrapMode := ACouche.WrapMode;
  end
  else
  begin
    // Propriétés non prises en charge sur l'export, mais utiles pour l'affichage et le choix des couches à l'écran
  end;
end;

function TfrmEdition.getRectangleFromObject(FMXObject: TFMXObject): TRectangle;
begin
  if assigned(FMXObject) and assigned(FMXObject.TagObject) and
    (FMXObject.TagObject is TRectangle) then
    result := FMXObject.TagObject as TRectangle
  else
    result := nil;
end;

procedure TfrmEdition.Hide;
begin
  Visible := false;
end;

procedure TfrmEdition.mmoCheminPathDataChange(Sender: TObject);
var
  Rectangle: TRectangle;
  couche: TPIMGCouche;
begin
  Rectangle := getRectangleFromObject(ProprietesChemin);
  couche := getCoucheFromObject(Rectangle);
  if assigned(couche) and (couche is TPIMGCoucheChemin) then
  begin
    (couche as TPIMGCoucheChemin).PathData := mmoCheminPathData.Text;
    ProjetOuvert.hasChanged := true;
    if (Rectangle.Children[0] is FMX.Objects.TPath) then
      (Rectangle.Children[0] as FMX.Objects.TPath).Data.Data :=
        mmoCheminPathData.Text;
  end;
end;

procedure TfrmEdition.nbMargeBasChange(Sender: TObject);
var
  Rectangle: TRectangle;
  couche: TPIMGCouche;
begin
  Rectangle := getRectangleFromObject(ProprietesMarges);
  couche := getCoucheFromObject(Rectangle);
  if assigned(couche) then
  begin
    couche.MargeBasse := trunc(nbMargeBas.Value);
    ProjetOuvert.hasChanged := true;
  end;
end;

procedure TfrmEdition.nbMargeDroiteChange(Sender: TObject);
var
  Rectangle: TRectangle;
  couche: TPIMGCouche;
begin
  Rectangle := getRectangleFromObject(ProprietesMarges);
  couche := getCoucheFromObject(Rectangle);
  if assigned(couche) then
  begin
    couche.MargeDroite := trunc(nbMargeDroite.Value);
    ProjetOuvert.hasChanged := true;
  end;
end;

procedure TfrmEdition.nbMargeGaucheChange(Sender: TObject);
var
  Rectangle: TRectangle;
  couche: TPIMGCouche;
begin
  Rectangle := getRectangleFromObject(ProprietesMarges);
  couche := getCoucheFromObject(Rectangle);
  if assigned(couche) then
  begin
    couche.MargeGauche := trunc(nbMargeGauche.Value);
    ProjetOuvert.hasChanged := true;
  end;
end;

procedure TfrmEdition.nbMargeHauteChange(Sender: TObject);
var
  Rectangle: TRectangle;
  couche: TPIMGCouche;
begin
  Rectangle := getRectangleFromObject(ProprietesMarges);
  couche := getCoucheFromObject(Rectangle);
  if assigned(couche) then
  begin
    couche.MargeHaute := trunc(nbMargeHaute.Value);
    ProjetOuvert.hasChanged := true;
  end;
end;

procedure TfrmEdition.PreviewTailleChange(Sender: TObject);
var
  img: TLayout;
  cb: tcheckbox;
  i: integer;
  largeur, hauteur: integer;
begin
  if not assigned(Sender) then
    exit;

  if not(Sender is tcheckbox) then
    exit;

  cb := (Sender as tcheckbox);
  largeur := cb.Tag;
  hauteur := trunc(cb.TagFloat);

  // Efface l'image de prévisualisation si elle est trouvée
  for i := zonePreviewImagesListe.ChildrenCount - 1 downto 0 do
    if (zonePreviewImagesListe.Children[i] is TLayout) and
      ((zonePreviewImagesListe.Children[i] as TLayout).tagstring = cb.Text) then
      zonePreviewImagesListe.Children[i].free;

  // créer une prévisualisation si la case est cochée
  if cb.IsChecked then
  begin
    img := GenereImage(largeur, hauteur);
    img.Parent := zonePreviewImagesListe;
    img.tagstring := cb.Text;
    img.Margins.Top := 5;
    img.Margins.right := 5;
    img.Margins.bottom := 5;
    img.Margins.left := 5;
  end;

  CalculeHauteurFlowLayout(zonePreviewImagesListe);
end;

procedure TfrmEdition.InitialisePreviewImagesList;
begin
  while zonePreviewImagesListe.ChildrenCount > 0 do
    zonePreviewImagesListe.Children[0].free;

  CalculeHauteurFlowLayout(zonePreviewImagesListe);
end;

procedure TfrmEdition.InitialiseTaillesListe;
var
  i: integer;
  cb: tcheckbox;
begin
  // Efface les éléments déjà présents
  for i := zonePreviewTaillesListe.ChildrenCount - 1 downto 0 do
    if (zonePreviewTaillesListe.Children[i] is tcheckbox) then
      (zonePreviewTaillesListe.Children[i] as tcheckbox).free;

  // Charge la liste à jour
  dm.tabTaillesImages.First;
  while not dm.tabTaillesImages.Eof do
  begin
    cb := tcheckbox.Create(zonePreviewTaillesListe);
    cb.Parent := zonePreviewTaillesListe;
    cb.Text := dm.tabTaillesImages.fieldbyname('largeur').AsString + 'x' +
      dm.tabTaillesImages.fieldbyname('hauteur').AsString;
    cb.Tag := dm.tabTaillesImages.fieldbyname('largeur').asinteger;
    cb.TagFloat := dm.tabTaillesImages.fieldbyname('hauteur').asinteger;
    cb.IsChecked := false;
    cb.OnChange := PreviewTailleChange;
    cb.Margins.Top := 0;
    cb.Margins.right := 0;
    cb.Margins.bottom := 3;
    cb.Margins.left := 0;
    dm.tabTaillesImages.next;
  end;

  // Recalcul de la hauteur de la zone de positionnement
  CalculeHauteurFlowLayout(zonePreviewTaillesListe);
end;

procedure TfrmEdition.SetCoucheActiveALEcran(const Value: TRectangle);
begin
  if assigned(FCoucheActiveALEcran) then
  begin
    FCoucheActiveALEcran.Stroke.Thickness := 1;
    FCoucheActiveALEcran.Stroke.Color := talphacolors.Black;
  end;
  FCoucheActiveALEcran := Value;
  if assigned(FCoucheActiveALEcran) then
  begin
    FCoucheActiveALEcran.Stroke.Thickness := 3;
    FCoucheActiveALEcran.Stroke.Color := talphacolors.green;
  end;
  AfficheProprietes(FCoucheActiveALEcran);
end;

procedure TfrmEdition.SetProjetOuvert(const Value: TPIMGProject);
var
  i: integer;
begin
  FProjetOuvert := Value;

  // Vider la liste des couches actuelles
  while zoneCouches.Content.ChildrenCount > 0 do
    zoneCouches.Content.Children[0].free;

  // Remplir la liste avec les couches du projet chargé
  for i := 0 to ProjetOuvert.Couches.Count - 1 do
    AjouteCouche(ProjetOuvert.Couches[i].TypeDeCouche, ProjetOuvert.Couches[i]);

  // Désactivation des inspecteurs de propriété
  CoucheActiveALEcran := nil;

  // Nettoyage de la zone de prévisualisation
  InitialisePreviewImagesList;
  InitialiseTaillesListe;
end;

procedure TfrmEdition.zonePreviewImagesListeResized(Sender: TObject);
begin
  CalculeHauteurFlowLayout(zonePreviewImagesListe);
end;

procedure TfrmEdition.zonePreviewTaillesListeResized(Sender: TObject);
begin
  CalculeHauteurFlowLayout(zonePreviewTaillesListe);
end;

{ TMyRSFmxSVGDocument }

procedure TMyRSFmxSVGDocument.SetCoucheSVG(const Value: TPIMGCoucheSVG);
begin
  FCoucheSVG := Value;
end;

initialization

TfrmEdition.maframe := nil;

finalization

// if assigned(TfrmEdition.maframe) then
// TfrmEdition.maframe.free;

end.
