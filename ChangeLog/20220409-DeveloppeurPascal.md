# 20220409 - [DeveloppeurPascal](https://github.com/DeveloppeurPascal)

Cette session de programmation a été enregistrée en direct sur [la chaîne Twitch de Patrick Prémartin](https://www.twitch.tv/patrickpremartin). Sa rediffusion est disponible sur [Serial Streameur](https://serialstreameur.fr/ajout-des-formats-ico-et-icns-a-l-export-des-icones-dans-pic-mob-generator-partie-5.html).

* ajout de la taille d'image 192x192 (Android)
* ajout de la taille d'image 24x24 (Android)
* ajout de la taille d'image 167x167 (iOS)
* ajout des tailles d'image 16x16, 32x32, 64x64, 256x256 (utilisées dans les icones Windows)
* activation de l'ouverture du navigateur depuis le lien du projet disponible dans "Aide / A propos"
* changement du numéro de version sur la boite de dialogue "Aide / A propos"
* en édition, ajout d'un bouton "rafraichir" sur la prévisualisation pour recalculer les images actives
* correction : élimination de fuites mémoires en fermeture de projet, TList<TPIMGCouche> a été remplacé par TObjectList<TPIMGCouche>.
* modification du format de fichier image par défaut dans la boite de dialogue utilisée lors du changement de l'image liée à une couche (tous formats par défaut pour simplifier le choix)
* ajout d'un bouton "monter couche"
* traitement du bouton "monter couche" qui change l'ordre des couches dans le projet
* ajout d'un bouton "descendre couche"
* traitement du bouton "descendre couche" qui change l'ordre des couches dans le projet
* ajout d'un bouton "supprimer couche"
* traitement du bouton "supprimer couche" qui élimine le niveau actif dans le projet
* ajout d'un bouton "afficher/masquer couche" (qui sera géré plus tard)
* export des icones du projet en .ICO (format Windows)
* export des icones du projet en .ICNS (format Mac)
* réinitialiser le chemin de la boite de dialogue lors de l'export
* prérenseigner le nom du fichier d'export avec celui du projet en cours
* en édition, relookage du bouton ajout rectangle
* en édition, relookage du bouton ajout chemin
* en édition, relookage du bouton ajout image
* correction d'un débordement d'entier en cas de sauvegarde d'un projet vide (sans couche)
* création et export de l'icone du programme pour Windows et Mac
* mise à jour des informations de version et de compilatin du projet pour Linux, Mac et Windows
* ajout du visuel du logiciel dans sa boite de dialogue A Propos
