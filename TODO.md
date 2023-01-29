# TODO List

* gérer une liste des derniers fichiers ouverts, dans un sous menu "rouvrir"

* traiter les TODO restants

* ajouter une propriété "visible" O/N sur les couches
* gérer le bouton "afficher/masquer" la couche active

* mettre une table des données globales saisies dans le programme pour la proposer en import aux utilisateurs du logiciel s'il y a des écarts ou nouveautés au niveau global

* assistant d'import des images dans Delphi / C++ Builder / RAD Studio

* trier liste des tailles en mise à jour (outils / options)
* pouvoir mettre des tailles avec des noms de fichiers en dur (ex noms Android)
* s'assurer de l'unicité des tailles en mise à jour


* modifier la table des tailles pour pouvoir les regrouper dans des catégories (par exemple le système d'exploitation à cibler, le magasin d'application, ...)


* étendre le programme pour gérer plusieurs projets à la fois sous forme d'onglets (ou rester à 1 seul)

* implémenter un mode clair
* implémenter un mode sombre
* mise en place de la saisie et du contrôle de la licence utilisateur

* afficher le nom du projet ouvert (sous forme d'onglet si on en gère plusieurs, sinon dans la barre de titre de la fenêtre principale)
* ajouter un événement sur le "hasChanged" du projet afin d'être informé dans l'écran pour éventuellement le signaler visuellement quelque part 

* ajouter les racourcis sur les options de menu : Ctrl+?? ou OPT+??? (Mac)

* si taille de la fenêtre principale est modifiée par l'utilisateur, la stocker et la restaurer si c'est possible au démarrage
* si l'écran (aka le moniteur) sur lequel on travaille est modifié en cours d'utilisation, stocker l'info pour restaurer le programme sur le même s'il est disponible lors du démarrage du programme

* ajouter un événement sur la gestion de la liste des tailles pour forcer un rafraichissement de la liste sur l'écran d'édition d'un projet lorsqu'elle est modifiée (évenement sur TFrame correspondante)

* pouvoir ouvrir un fichier projet depuis la ligne de commande (Windows + Linux)
* associer l'extension PIMG au programme sous Windows
* associer l'extension PIMG au programme sous Linux (si possible)

* pouvoir ouvrir un fichier projet depuis le Finder (MacOS)
* associer l'extension PIMG au programme sous Mac
* ajouter une commande CLI pour exporter directement les images depuis la ligne de commande (nom fichier projet / nom dossier d'export)
* pouvoir exporter plusieurs projets à la fois (genre macro) depuis l'interface utilisateur 
* pouvoir exporter plusieurs projets à la fois (genre macro) depuis la ligne de commande


* lorsque les tailles d'icones à exporter seront regroupables par catégorie, prévoir un nom de dossier facultatif dans la catégorie pour les séparer lors de l'exportation



## Ecran d'édition
* dans le menu "edition", ajouter des options pour ajouter les différents types de couches
* dans le menu "edition", ajouter des options pour supprimer la couche actuellement sélectionnée
* en cas de modification de la largeur des colonnes avec les sliders, enregistrer l'information pour le chargement suivant du programme
* sur les rectangles, gérer le type de trait du contour
* sur les rectangles, gérer l'épaisseur du trait du contour
* sur les rectangles, gérer le radius X (si on garde le contour)
* sur les rectangles, gérer le radius Y (si on garde le contour)
* sur les chemins de SVG, gérer le type de trait
* sur les chemins de SVG, gérer l'épaisseur du trait


* ajouter une option de changement de couleur du fond de prévisualitation pour vérifier ce que donnent les transparences

* sur export des images, modifier la boite de dialogue permettant la sélection d'un dossier car elle ne le fait pas (choix de fichier obligatoire lié au composant boite de dialogue utilisé)

* gérer le radius de sortie (pour avoir un carré, carré arrondi ou cercle)

## Extensions futures

* pouvoir modifier le comportement des couches pour une ou plusieurs tailles d'images
* pouvoir valider la liste des tailles à générer pour un projet plutôt que toutes les faire systématiquement
* pouvoir utiliser un fichier Adobe Illustrator en direct
* pouvoir utiliser un fichier Inkscape en direct

* ajouter un module de recherche de mise à jour du logiciel et de suggestion d'installation (nouvelle option de menu ou recherche automatique)

* faire vidéo de démo du logiciel
* mise en vente du logiciel sur Microsoft Store
* mise en vente du logiciel sur Mac App Store

* pemettre le clonage d'une couche pour en créer une autre

* permettre de récupérer une couleur d'un choix (trait ou remplissage) pour l'appliquer ailleurs


* reste potentiel bogue sur fichiers ICNS générés pour les tailles 16x16 et 32x32 qui ne sont pas reconnues correctement par IcoFX ni l'iMac sous High Sierra (qui affiche n'importe quoi sur ce format)

* éventuellement permettre un export plus cible : que JPG, que PNG, que ICO, que ICNS, ... depuis les menus ou sous forme de boite de dialogue intermédiaire => menus ajoutés, plus qu'à coder les exports séparés et remodifier le global


* pouvoir mettre plusieurs images sur la même image et les choisir en fonction de la taille de la zone d’affichage.

* Ajouter une prévisualisation des images utilisées dans un ICO / ICNS et permettre de remplacer l’une d’entre elles par une image extérieure.

* Avoir une couche de type « background » qui pourrait être transparente pour les PNG et d’une couleur fixée pour les JPG. Forcément la plus basse de la liste des couches.

* gérer menu export / PNG
* gérer menu export / ICO
* gérer menu export / ICNS

* renommer "couche" en "calque" partout 

* ajout d'autres formes que le rectangle,
* lien entre le programme et l'extension PIMG sur Mac,
* lien entre le programme et l'extension PIMG sur Windows,


* repasser la lecture et le traitement des SVG dans le TImage standard (cf FAQ RiverSoft : il faut juste ajouter l'unité RSImaging.svgimage au projet pour importer les éléments nécessaires)

* bogue : le bouton "effacer" ne fonctionne pas sur les calques SVG

* lors de la génération des icones (options(s) d'export), mettre un écran d'attente pour montrer qu'il se passe quelque chose


* sur écran d'accueil, proposer l'ouverture d'un projet existant ou la création d'un nouveau projet (ça a perturbé l'équipe de validation chez Apple, c'est effectivement un point d'UX intéressant à améliorer)

* ajouter un catalogue d'exemples d'icônes dans le logiciel (à piocher sur un site distant, donc faire les exemples et faire le site proposant les exemples et leur téléchargement)

* pouvoir saisir une valeur de couleur en hexa dans les blocs de sélection (ou en changer)

* bogue : plantages dans la manipulation des calques après suppression de l'un d'entre eux (rectangle) sur Mac

* ajouter une opacité au niveau des couches d'images et de formes


* voir https://quality.embarcadero.com/browse/RSP-21335 et https://developer.android.com/guide/practices/ui_guidelines/icon_design_adaptive

* pour se greffer sur l'expert d'Adriano Santos, proposer une DLL permettant la génération d'une image depuis un fichier PIMG (dimensions, format (JPG/PNG/ICO/ICNS) et chemin de stockage à spécifier)
