# Format de stockage des projets

Version du format 5 en date du 21/04/2022.

Extension de fichier : PIMG

Les numéros de version sont de type byte.
Les types de blocs sont de type byte.
Les longueurs et nombres sont de type cardinal.

Stockage sous forme de stream Delphi :
- version du fichier : 5
Couches (version 1) :
- nombre de couches
- X blocs liés aux informations de chaque couche

=> rien
- type de bloc : 0

=> bloc TPath :
- type de bloc : 1
- version du bloc : 4
- couleur
- longueur du data (nb caractères)
- data
- Données du bloc racine commun à tous les autres
- wrapmode du chemin (en byte)

=> bloc TImage : (JPEG, PNG, SVG via RiverSoftAVG)
- type de bloc : 2
- version du bloc : 5
- taille du buffer de l'image (= nombre d'octets à charger pour recomposer le fichier image)
- bitmap (si taille > 0 c'est le contenu de l'image au format PNG)
- Données du bloc racine commun à tous les autres
- wrapmode de l'image (en byte)

=> bloc TRectangle :
- type de bloc : 3
- version du bloc : 3
- couleur du rectangle
- Données du bloc racine commun à tous les autres

=> bloc TRSSVGImage + TRSFMXSVGDocument :
- type de bloc : 4
- version du bloc: 1
- taille du SVG (en octets)
- source du SVG (flux d'octets)
- wrapmode du SVG (en byte)
- Données du bloc racine commun à tous les autres

=> bloc racine :
- version du bloc : 1
- marge haute (% par rapport à la hauteur totale, en byte)
- marge droite (% par rapport à la largeur totale, en byte)
- marge basse (% par rapport à la hauteur totale, en byte)
- marge gauche (% par rapport à la largeur totale, en byte)
