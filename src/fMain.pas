unit fMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Menus,
  uProjetPIMG, FMX.Layouts, uDMImages, Olf.FMX.AboutDialog;

type
  TfrmMain = class(TForm)
    MainMenu1: TMainMenu;
    mnuFichier: TMenuItem;
    mnuOutils: TMenuItem;
    mnuAide: TMenuItem;
    mnuNouveau: TMenuItem;
    mnuOuvrir: TMenuItem;
    mnuEnregistrer: TMenuItem;
    mnuFermerProjet: TMenuItem;
    mnuQuitter: TMenuItem;
    mnuOptions: TMenuItem;
    mnuAPropos: TMenuItem;
    mnuMacOS: TMenuItem;
    mnuPreferences: TMenuItem;
    mnuAProposMac: TMenuItem;
    AProposDialog1: TOlfAboutDialog;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    mnuProjet: TMenuItem;
    mnuExportAll: TMenuItem;
    OpenDialogExportImages: TOpenDialog;
    mnuExportICO: TMenuItem;
    mnuExportICNS: TMenuItem;
    mnuExportPNG: TMenuItem;
    mnuCalques: TMenuItem;
    mnuCalquesNouveauChemin: TMenuItem;
    mnuCalquesNouveauRectangle: TMenuItem;
    mnuCalquesNouveauSVG: TMenuItem;
    mnuCalquesNouvelleImage: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure mnuAProposClick(Sender: TObject);
    procedure mnuQuitterClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure mnuFermerProjetClick(Sender: TObject);
    procedure mnuOptionsClick(Sender: TObject);
    procedure mnuEnregistrerClick(Sender: TObject);
    procedure mnuNouveauClick(Sender: TObject);
    procedure mnuOuvrirClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure mnuExportAllClick(Sender: TObject);
    procedure AProposDialog1URLClick(const AURL: string);
    procedure mnuExportICNSClick(Sender: TObject);
    procedure mnuExportICOClick(Sender: TObject);
    procedure mnuExportPNGClick(Sender: TObject);
    procedure mnuCalquesNouveauCheminClick(Sender: TObject);
    procedure mnuCalquesNouveauRectangleClick(Sender: TObject);
    procedure mnuCalquesNouveauSVGClick(Sender: TObject);
    procedure mnuCalquesNouvelleImageClick(Sender: TObject);
  private
    { Déclarations privées }
    ProjetOuvert: TPIMGProject;
  public
    { Déclarations publiques }
    procedure AfficheFenetre(Frm: TFrame);
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.fmx}

uses fOutilsOptions, System.IOUtils, fEdition, uDM,
  u_urlOpen;

procedure TfrmMain.AfficheFenetre(Frm: TFrame);
begin
  if assigned(Frm) then
  begin
    Frm.Parent := self;
    Frm.Align := TAlignLayout.Contents;
    Frm.visible := true;
    Frm.BringToFront;
    Frm.SetFocus;
  end
  else
    raise exception.Create('Invalid windows');
end;

procedure TfrmMain.AProposDialog1URLClick(const AURL: string);
begin
  if not AURL.trim.IsEmpty then
    url_Open_In_Browser(AURL);
end;

procedure TfrmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if ProjetOuvert.hasChanged then
  begin
    CanClose := false;
    mnuFermerProjetClick(Sender);
  end;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  ProjetOuvert := TPIMGProject.Create;
{$IF Defined(MACOS)}
  mnuQuitter.visible := false;
  // Fichier/Quitter remplacé par Application/Quitter
  mnuOptions.visible := false;
  // Outils/Options remplacé par Application/Préférences
  mnuAPropos.visible := false; // Aide/APropos remplacé par Application/A Propos
  mnuOutils.visible := false; // menu vide
  mnuAide.visible := false; // menu vide
{$ELSE}
  mnuMacOS.visible := false;
{$ENDIF}
  mnuProjet.Enabled := false;
  mnuCalques.Enabled := false;
  mnuEnregistrer.Enabled := false;
  mnuFermerProjet.Enabled := false;
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  ProjetOuvert.Free;
end;

procedure TfrmMain.mnuAProposClick(Sender: TObject);
begin
  AProposDialog1.execute;
end;

procedure TfrmMain.mnuCalquesNouveauCheminClick(Sender: TObject);
begin
  TfrmEdition.getCurrent.btnAddPathClick(Sender);
end;

procedure TfrmMain.mnuCalquesNouveauRectangleClick(Sender: TObject);
begin
  TfrmEdition.getCurrent.btnAddRectangleClick(Sender);
end;

procedure TfrmMain.mnuCalquesNouveauSVGClick(Sender: TObject);
begin
  TfrmEdition.getCurrent.btnAddSVGClick(Sender);
end;

procedure TfrmMain.mnuCalquesNouvelleImageClick(Sender: TObject);
begin
  TfrmEdition.getCurrent.btnAddImageClick(Sender);
end;

procedure TfrmMain.mnuEnregistrerClick(Sender: TObject);
var
  NomFichier: string;
  Chemin: string;
begin
  if ProjetOuvert.Filename.IsEmpty then
  begin
    SaveDialog1.InitialDir := tpath.GetDocumentsPath;
    // TODO : reprendre le dernier dossier d'enregistrement
    if SaveDialog1.execute then
    begin
      NomFichier := trim(SaveDialog1.Filename);
      if (not NomFichier.IsEmpty) and
        NomFichier.EndsWith(TPIMGProject.FileExtension) then
      begin
        if tfile.Exists(NomFichier) then
          ProjetOuvert.SaveToFile(NomFichier)
        else
        begin
          Chemin := tpath.GetDirectoryName(NomFichier);
          if not tdirectory.Exists(Chemin) then
            tdirectory.CreateDirectory(Chemin);
          ProjetOuvert.SaveToFile(NomFichier);
        end;
        // TODO : enregistrer le chemin d'enregistrement dans les paramètres
        caption := tpath.GetFileNameWithoutExtension(NomFichier) +
          ' - Pic Mob Generator';
      end;
    end;
  end
  else
    ProjetOuvert.SaveToFile;
end;

procedure TfrmMain.mnuExportAllClick(Sender: TObject);
const
  CNbBMPPerICO = 10; // Nb images de formats différents dans un fichier ICO
  CNbBMPPerICNS = 12; // Nb images de formats différents dans un fichier ICNS
var
  CheminDeStockage: string;
  l: tlayout;
  bmp: tbitmap;
  CheminDeFichier: string;
  largeur, hauteur: integer;
  fs: tfilestream;
  ms: array [1 .. (CNbBMPPerICO + CNbBMPPerICNS)] of tmemorystream;
  b: uint8; // byte, 1 octets, entier non signé
  w: uint16; // word, 2 octets, entier non signé
  c: uint32; // cardinal, 4 octets, entier non signé
  offset: uint32; // 4 octets : position de l'image dans le flux de l'ICO
  taille: uint32;
  // 4 octets, entier non signé pour la taille du fichier ICSN par exemple
  i: integer;
  FormatICNS: string;
  j: byte;
begin
  OpenDialogExportImages.Filename := ProjetOuvert.Filename;
  CheminDeStockage := tpath.GetDirectoryName(ProjetOuvert.Filename);

  if CheminDeStockage.IsEmpty or (not tdirectory.Exists(CheminDeStockage)) then
  begin
    CheminDeStockage := tpath.GetDocumentsPath;
    OpenDialogExportImages.Filename := '';
  end;

  OpenDialogExportImages.InitialDir := CheminDeStockage;
  if OpenDialogExportImages.execute then
  begin
    // TODO : à modifier lorsqu'on pourra sélectionner directement un dossier plutôt que faire un fichier bidon dans le dossier qui nous intéresse
    CheminDeStockage := tpath.GetDirectoryName(OpenDialogExportImages.Filename);
    // boucle sur les formats d'images pour générer leds images et enregistrer le résultat
    CheminDeFichier := tpath.Combine(CheminDeStockage,
      tpath.GetFileNameWithoutExtension(ProjetOuvert.Filename));

    // Export des images PNG dans les différentes tailles demandées
    dm.tabTaillesImages.First;
    while not dm.tabTaillesImages.Eof do
    begin
      largeur := dm.tabTaillesImages.FieldByName('largeur').asinteger;
      hauteur := dm.tabTaillesImages.FieldByName('hauteur').asinteger;
      l := TfrmEdition.getCurrent.GenereImage(largeur, hauteur);
      if assigned(l) then
        try
          l.Parent := self;
          // sans ça, pas de contexte de dessin, donc images vides
          bmp := l.MakeScreenshot;
          if assigned(bmp) then
            try
              bmp.SaveToFile(CheminDeFichier + '-' + largeur.tostring + 'x' +
                hauteur.tostring + '.png');
              bmp.SaveToFile(CheminDeFichier + '-' + largeur.tostring + 'x' +
                hauteur.tostring + '.jpg');
            finally
              bmp.Free;
            end;
        finally
          l.Free;
        end;
      dm.tabTaillesImages.next;
    end;

    // Export en format ICO (icônes Windows)
    // https://en.wikipedia.org/wiki/ICO_(file_format)
    // au cas où https://en.wikipedia.org/wiki/Favicon
    fs := tfilestream.Create(CheminDeFichier + '.ico', fmcreate);
    try
      w := 0; // must be 0
      fs.WriteData(w);
      w := 1; // ICO file
      fs.WriteData(w);
      w := CNbBMPPerICO; // CNbBMPPerICO images in the file
      fs.WriteData(w);
      offset := 6 (* header *) + CNbBMPPerICO *
        16 (* directory, CNbBMPPerICO images *);
      // offset du bitmap
      for i := 1 to CNbBMPPerICO do
      begin
        case i of
          1:
            begin
              largeur := 16;
              hauteur := 16;
            end;
          2:
            begin
              largeur := 20;
              hauteur := 20;
            end;
          3:
            begin
              largeur := 24;
              hauteur := 24;
            end;
          4:
            begin
              largeur := 32;
              hauteur := 32;
            end;
          5:
            begin
              largeur := 40;
              hauteur := 40;
            end;
          6:
            begin
              largeur := 48;
              hauteur := 48;
            end;
          7:
            begin
              largeur := 64;
              hauteur := 64;
            end;
          8:
            begin
              largeur := 96;
              hauteur := 96;
            end;
          9:
            begin
              largeur := 128;
              hauteur := 128;
            end;
          10:
            begin
              largeur := 256;
              hauteur := 256;
            end;
        else
          raise exception.Create('taille inconnue');
        end;

        l := TfrmEdition.getCurrent.GenereImage(largeur, hauteur);
        if assigned(l) then
          try
            l.Parent := self;
            // sans ça, pas de contexte de dessin, donc images vides
            bmp := l.MakeScreenshot;
            if assigned(bmp) then
              try
                ms[i] := tmemorystream.Create;
                bmp.SaveToStream(ms[i]);
                if (largeur > 255) then
                  b := 0
                else
                  b := largeur;
                fs.WriteData(b);
                if (hauteur > 255) then
                  b := 0
                else
                  b := hauteur;
                fs.WriteData(b);
                b := 0; // nb colors
                fs.WriteData(b);
                b := 0; // 0
                fs.WriteData(b);
                w := 0; // color planes
                fs.WriteData(w);
                w := 0; // bits per pixel
                fs.WriteData(w);
                c := ms[i].Size; // taille du bitmap
                fs.WriteData(c);
                fs.WriteData(offset);
                offset := offset + c;
              finally
                bmp.Free;
              end;
          finally
            l.Free;
          end;
      end;
      for i := 1 to CNbBMPPerICO do
        try
          ms[i].Position := 0;
          fs.CopyFrom(ms[i]);
        finally
          ms[i].Free;
        end;
    finally
      fs.Free;
    end;

    // Export en format ICNS (icônes MacOS)
    // https://fr.wikipedia.org/wiki/Apple_Icon_Image
    // https://en.wikipedia.org/wiki/Apple_Icon_Image_format
    taille := 4 + 4; // header global 'icns'+taille totale
    for i := 1 to CNbBMPPerICNS do
    begin
      case i of
        1:
          begin
            largeur := 16;
            hauteur := 16;
          end;
        2:
          begin
            largeur := 32;
            hauteur := 32;
          end;
        3:
          begin
            largeur := 32;
            hauteur := 32;
          end;
        4:
          begin
            largeur := 64;
            hauteur := 64;
          end;
        5:
          begin
            largeur := 128;
            hauteur := 128;
          end;
        6:
          begin
            largeur := 256;
            hauteur := 256;
          end;
        7:
          begin
            largeur := 256;
            hauteur := 256;
          end;
        8:
          begin
            largeur := 512;
            hauteur := 512;
          end;
        9:
          begin
            largeur := 512;
            hauteur := 512;
          end;
        10:
          begin
            largeur := 1024;
            hauteur := 1024;
          end;
        11:
          begin
            largeur := 32;
            hauteur := 32;
          end;
        12:
          begin
            largeur := 16;
            hauteur := 16;
          end;
      else
        raise exception.Create('taille inconnue');
      end;

      l := TfrmEdition.getCurrent.GenereImage(largeur, hauteur);
      if assigned(l) then
        try
          l.Parent := self;
          // sans ça, pas de contexte de dessin, donc images vides
          bmp := l.MakeScreenshot;
          if assigned(bmp) then
            try
              ms[i] := tmemorystream.Create;
              bmp.SaveToStream(ms[i]);
              taille := taille + 4 + 4 + ms[i].Size; // header+bitmap PNG
            finally
              bmp.Free;
            end;
        finally
          l.Free;
        end;
    end;

    fs := tfilestream.Create(CheminDeFichier + '.icns', fmcreate);
    try
      b := ord('i');
      fs.WriteData(b);
      b := ord('c');
      fs.WriteData(b);
      b := ord('n');
      fs.WriteData(b);
      b := ord('s');
      fs.WriteData(b);
      for j := sizeof(taille) - 1 downto 0 do
      begin
        b := (pbyte(@taille) + j)^;
        fs.WriteData(b);
      end;
      // fs.WriteData(taille);

      for i := 1 to CNbBMPPerICNS do
        try
          case i of
            1:
              FormatICNS := 'is32'; // 16x16 24 bits
            2:
              FormatICNS := 'ic11'; // 16x16@2x
            3:
              FormatICNS := 'il32'; // 32x32 24 bits
            4:
              FormatICNS := 'ic12'; // 32x32@2x
            5:
              // Apple veut 4 bytes de plus              FormatICNS := 'it32'; // 128x128 24 bits
              FormatICNS := 'ic07'; // 128x128 24 bits
            6:
              FormatICNS := 'ic13'; // 128x128@2x
            7:
              FormatICNS := 'ic08'; // 256x256
            8:
              FormatICNS := 'ic14'; // 256x256@2x
            9:
              FormatICNS := 'ic09'; // 512x512
            10:
              FormatICNS := 'ic10'; // 512x512@2x
            11:
              FormatICNS := 'l8mk'; // 32x32
            12:
              FormatICNS := 's8mk'; // 16x169
          else
            raise exception.Create('taille inconnue');
          end;
          b := ord(FormatICNS.Chars[0]);
          fs.WriteData(b);
          b := ord(FormatICNS.Chars[1]);
          fs.WriteData(b);
          b := ord(FormatICNS.Chars[2]);
          fs.WriteData(b);
          b := ord(FormatICNS.Chars[3]);
          fs.WriteData(b);
          if (FormatICNS = 'it32') then
          begin
            c := 0;
            fs.WriteData(c);
            c := ms[i].Size + 4 + 8;
            for j := sizeof(c) - 1 downto 0 do
            begin
              b := (pbyte(@c) + j)^;
              fs.WriteData(b);
            end;
            // fs.WriteData(c);
          end
          else
          begin
            c := ms[i].Size + 8;
            for j := sizeof(c) - 1 downto 0 do
            begin
              b := (pbyte(@c) + j)^;
              fs.WriteData(b);
            end;
            // fs.WriteData(c);
          end;
          ms[i].Position := 0;
          fs.CopyFrom(ms[i]);
        finally
          ms[i].Free;
        end;
    finally
      fs.Free;
    end;

    // Fin de l'export
    ShowMessage('Export des images terminé.');
  end;
end;

procedure TfrmMain.mnuExportICNSClick(Sender: TObject);
begin
  // TODO : à compléter
end;

procedure TfrmMain.mnuExportICOClick(Sender: TObject);
begin
  // TODO : à compléter
end;

procedure TfrmMain.mnuExportPNGClick(Sender: TObject);
begin
  // TODO : à compléter
end;

procedure TfrmMain.mnuFermerProjetClick(Sender: TObject);
begin
  if ProjetOuvert.hasChanged then
  begin
    // TODO : proposer enregistrement du projet
  end;
  TfrmEdition.getCurrent.hide;
  ProjetOuvert.Initialise;
  mnuProjet.Enabled := false;
  mnuCalques.Enabled := false;
  mnuEnregistrer.Enabled := false;
  mnuFermerProjet.Enabled := false;
  caption := 'Pic Mob Generator';
end;

procedure TfrmMain.mnuNouveauClick(Sender: TObject);
begin
  mnuFermerProjetClick(Sender);
  ProjetOuvert.Initialise;
  TfrmEdition.getCurrent.ProjetOuvert := ProjetOuvert;
  AfficheFenetre(TfrmEdition.getCurrent);
  mnuProjet.Enabled := true;
  mnuCalques.Enabled := true;
  mnuEnregistrer.Enabled := true;
  mnuFermerProjet.Enabled := true;
  caption := 'Untitled - Pic Mob Generator';
end;

procedure TfrmMain.mnuOptionsClick(Sender: TObject);
begin
  AfficheFenetre(TfrmOutilsOptions.getCurrent);
end;

procedure TfrmMain.mnuOuvrirClick(Sender: TObject);
var
  NomFichier: string;
begin
  OpenDialog1.InitialDir := tpath.GetDocumentsPath;
  // TODO : prendre le dernier chemin utilisé (cf paramètres)
  if OpenDialog1.execute then
  begin
    NomFichier := trim(OpenDialog1.Filename);
    if (not NomFichier.IsEmpty) and
      NomFichier.EndsWith(TPIMGProject.FileExtension, true) and
      tfile.Exists(NomFichier) then
    begin
      // TODO : enregistrer le chemin du fichier pour le proposer la prochaine fois
      // TODO : si gestion des fichier récents, l'ajouter à la liste
      mnuFermerProjetClick(Sender);
      ProjetOuvert.LoadFromFile(NomFichier);
      TfrmEdition.getCurrent.ProjetOuvert := ProjetOuvert;
      AfficheFenetre(TfrmEdition.getCurrent);
      mnuProjet.Enabled := true;
      mnuCalques.Enabled := true;
      mnuEnregistrer.Enabled := true;
      mnuFermerProjet.Enabled := true;
      caption := tpath.GetFileNameWithoutExtension(NomFichier) +
        ' - Pic Mob Generator';
    end;
  end;
end;

procedure TfrmMain.mnuQuitterClick(Sender: TObject);
begin
  close;
end;

initialization

{$IFDEF DEBUG}
  ReportMemoryLeaksOnShutdown := true;
{$ENDIF}

end.
