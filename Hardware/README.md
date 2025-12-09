

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
[Référence moteur](https://www.stepperonline.ca/e-series-nema-17-bipolar-1-8deg-17ncm-24-07oz-in-1a-42x42x23mm-4-wires-17he08-1004s.html?srsltid=AfmBOoqD_WQaT4YcUpz0k2ZOEeU2qkR0t9uZcpgcZBa46N7mLR8tk0RL)


| Caractéristique | Valeur |
|---------|---------------|
| Couple  | 0,17 Nm |
| Taille  | 4,23 x 4,23 x 2,3 cm |
| Phase | 2 |
| Tension nominale max | 12 VDC |
| Vitesse | 200 tr/min |


## b - Test des moteurs

On a testé les moteurs et drivers actuels pour s'assurer de leur bon fonctionnement.

Le driver utilisé comporte dix broches : 

| Broche | Fonction | Valeur |
|---------|---------|------|
| **GND** (x2) | Masse | - |
| **Vmot** | Alimentation du moteur | 12V (entre 8V et 35V) |
| **STEP** | signal de commande du moteur | Signal PWM |
| **DIR** | Sens de rotation | 5V ou 0V |
| **VDD** | Alimentation du driver | 3,3V (entre 3V et 5,5V) |   
| **2A, 1A, 1B, 2B**  | entrées du moteur | - |

On souhaitait tout d'abord faire tourner le moteur dans une seule direction. On devait donc générer un signal PWM pour la broche **STEP** du driver. Pour cela, on a configuré une broche de la carte pour qu'elle génère le signal PWM à l'aide d'un timer. La carte STM32 a également servi de source d'alimentation pour les broches **VDD**, **DIR** et **GND**.

Le signal PWM généré par la carte est caractérisée par sa **fréquence** et son **rapport cyclique**.


La fréquence de la PWM est reliée à la fréquence de l'horloge :

$$
f_{PWM} = \frac{f_{clock}}{(PSC + 1)(ARR + 1)}
$$

Avec : 

- **f_clock = 84MHz** : la fréquence de l'horloge de la carte STM32

- **PSC** : le prescaler

- **ARR** : l'auto-Reload Register

On a choisi **PSC = 84** et **ARR = 1999**, ce qui correspond donne une fréquence de :

$$
f_{PWM} = 500 \text{Hz}.
$$

Le rapport cyclique est réglé grâce au paramètre CCR de la PWM : 

$$
rapport~cyclique = \frac{CCR}{(ARR+1)}
$$

On souhaite avoir un rapport cyclique de 0,5. On choisit donc de prendre :

$$ 
CCR = \frac{ARR+1}{2} 
$$


En faisant cela, on remarque que le moteur tourne bien. On diminue progressivement ARR pour augmenter la fréquence. On est arrivé jusqu'à **ARR = 1249**. Toutefois, le moteur n'arrivait pas tout le temps à tourner à cette fréquence. 
On est donc descendu à la valeur finale ARR = 1399, ce qui fonctionne. 
La fréquence de la PWM est donc de **714 Hz**, ce qui signifie qu'une face du rubik's cube peut faire un tour complet en **0,280 s**, ce qui est suffisant pour satisfaire le critère de rapidité du cahier des charges.

Nous avons testé de cette manière l'ensemble des moteurs et drivers. Cela nous a permis de voir qu'ils sont tous fonctionnels.

# 2 - PCB pour le driver

Nous avons décidé de réutiliser les modules avec driver faits l'année précédente pour piloter les moteurs. Cependant, il manquait un module. 
On a donc reproduit sur kicad le module existant.

Les fichiers gerbers qui ont été réalisés sont les suivants : [dossier Gerbers](https://github.com/ChristopheBuiH/Projet-Rubik-s-Cube/blob/main/Hardware/gerbers_module_driver_V2.zip).












