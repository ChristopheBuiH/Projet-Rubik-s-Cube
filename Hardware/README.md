

# Hardware

Cette partie comprend le choix des composants et la conception du chassis.

# 1 - Choix des composants

Voici un excel qui dresse une liste des composants envisagés:
[Liste composants](https://docs.google.com/spreadsheets/d/1jq-PL6Vh3QKGo2s5FMimd9EOxpTKTjlahbOYSqwu5ok/edit?gid=665021889#gid=665021889)

## a - Moteurs

Notre composant actuel est le modèle ST4118L1804-A :

| Caractéristique | Valeur |
|---------|---------------|
| Couple  | 0,5 Nm |
| Taille  | 4,23 x 4,23 x 5 cm |
| Phase | 2 |
| Tension nominale max | 24 VDC |
| Vitesse | 2000 tr/min |

Dans une optique d'avoir un produit final de taille réduite, on veut un moteur qui satisfait les critères suivant : 

| Critère | Spécification | Commentaire |
|---------|---------------|-------------|
| Couple  | 0,1 Nm minimum | Couple suffisant pour un rubik's cube |
| Taille  | < 4,23 x 4,23 x 5 cm | On veut un moteur plus petit |
| Phase | 2 | Pour correspondre à nos drivers |
| Tension nominale max | 35 VDC | Pour correspondre à nos drivers |
| Vitesse | Rapide (3 tr/s suffit) | Assez rapide par rapport à notre algorithme de résolution |
| Prix | < 20 € |


Cela nous a amené à choisir le modèle suivant : 17HE08-1004S , 
[Référence moteur](https://www.amazon.fr/STEPPERONLINE-bipolaire-Longueur-imprimante-extrudeuse/dp/B0B93PNYCP/261-3319972-3897809?pd_rd_w=ZNp2j&content-id=amzn1.sym.a42e8b37-d3d3-4f9a-8311-e1db829f7bde&pf_rd_p=a42e8b37-d3d3-4f9a-8311-e1db829f7bde&pf_rd_r=CXAA8PGF1336S3D15ZZ1&pd_rd_wg=3EKfO&pd_rd_r=05e90827-fbcf-4a79-965a-68498e4e0b50&pd_rd_i=B0B93PNYCP&psc=1)


| Caractéristique | Valeur |
|---------|---------------|
| Couple  | 0,5 Nm |
| Taille  | 4,23 x 4,23 x 5 cm |
| Phase | 2 |
| Tension nominale max | 24 VDC |
| Vitesse | 2000 tr/min |












