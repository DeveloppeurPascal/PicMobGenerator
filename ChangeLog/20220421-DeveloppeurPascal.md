# 20220421 - [DeveloppeurPascal](https://github.com/DeveloppeurPascal)

Cette session de programmation a été enregistrée en direct sur [la chaîne Twitch de Patrick Prémartin](https://www.twitch.tv/patrickpremartin). Sa rediffusion est disponible sur [Serial Streameur](https://serialstreameur.fr/ajout-de-la-prise-en-charge-des-fichiers-svg-comme-couches-d-icones-dans-pic-mob-generator-partie-6.html).

* mise en constantes des numéros de version des blocs et du fichier PIMG
* ajout du format SVG en tant que nouvelle couche dans le format PIMG (utilisation de la librarie Riversoft (http://www.riversoftavg.com/svg.htm)
* traitement des calques et propriétés liées au calque SVG (création, chargement, sauvegarde)
* ajout d'options de menu pour créer les calques sans passer par les boutons
* ajout d'options de menu pour faire des exports partiels (à gérer ultérieurement)
* traitement de l'option de menu d'ajout d'images
* traitement de l'option de menu d'ajout de rectangles
* traitement de l'option de menu d'ajout de chemins SVG
* traitement de l'option de menu d'ajout de fichiers SVG
* retrait de 'iw' des WrapMode sur les Fichiers SVG de RiverSoft (iwStretch, iwCenter, ...)
* mise à jour de la doc du format de fichiers PIMG
* mise à jour de la TODO list
* ajouter un export d'images en 128x128

* test de génération des icones de Pairpix en prenant le "P" en tant que SVG depuis un export Illustrator

* tests de modifications des PNG pour tenter de passer la validation technique d'Apple sur l'App Store, mais toujours rejet avec la même erreur sasn information suffisante pour débloquer le problème :
ERROR ITMS-90717: "Invalid App Store Icon. The App Store Icon in the asset catalog in 'pairpix.app' can't be transparent nor contain an alpha channel."
