Ces commandes sont celles nécessaires pour paramétrer la connexion réseau sur la carte. La première configure l'adresse IP et le masque de sous-réseau de la carte (pour le port Ethernet) et la deuxième déclare que la passerelle par défaut est le port Ethernet de mon PC.

sudo ifconfig eth0 [IP_carte] netmask [masque] up 
sudo route add default gw [IP_hôte]

Pour transférer des fichiers, je crée un serveur http sur mon PC avec Python, puis j'utilise wget avec l'adresse IP de mon PC et le port configuré sur le serveur

python -m http.server [port]]
wget http://[IP_hôte]:[port]/[nom_du_fichier]