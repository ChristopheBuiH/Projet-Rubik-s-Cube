#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>
#include <unistd.h>
#include <fcntl.h>
#include <time.h>
#include <sys/mman.h>
#include <stdbool.h>

#include "utils.h"

// Adresse de base du pont Lightweight HPS-to-FPGA 
#define LWHPS2FPGA_BASE 0xFF200000 
// Taille de la plage mémoire à mapper
#define LWHPS2FPGA_SPAN 0x00200000
// Offset de l'IP dans la mémoire
#define IP_OFFSET 0x00001000

// Fonction pour séparer une chaîne de caractères binaire en 20 mots de taille souhaitée 
// (la chaîne de caractère doit avoir un multiple de six comme longueur)
void separateur(const char *str, uint8_t resultat[32]) {
    int len = strlen(str);
    int width = 6;
    int nb_mots = len / 6;
    char listemots[nb_mots][7];

    for (int i = 0; i < nb_mots; i++) {
        for (int j = 0; j < width; j++) {
            listemots[i][j] = str[(i * width) + j];
        }
        listemots[i][width] = '\0';
        resultat[i] = convertisseur32bits(listemots[i]);
    }

    for (int i = nb_mots; i < 32; i++) {
        resultat[i] = 0;
    }
}

/*int Recuperateur(const char *chemin, char *buffer, size_t bufferSize) {
    FILE *fp;
    char commande[512];

    snprintf(commande, sizeof(commande), "java -jar \"%s\"", chemin);

    fp = _popen(commande, "r");

    // Gestion erreurs
    if (fp == NULL) {
        _wperror(L"Erreur");
        return 1;
    }

    while (fgets(buffer, bufferSize, fp) != NULL) {
        printf("Sortie Java : %s", buffer);
    }

    // Nettoyer la dernière ligne lue
    size_t blen = strcspn(buffer, "\r\n");
    buffer[blen] = '\0';

    _pclose(fp);
    return 0;
}
*/
uint32_t convertisseur32bits(const char *binaire) {
    uint32_t motbits = 0;
    while (*binaire) {
        motbits <<= 1;
        if (*binaire == '1') motbits |= 1;
        binaire++;
    }
    return motbits;
}

int main() {
    char buffer[256];
    uint8_t resultat[32] = {0x0};

    // int chaine = Recuperateur("C:\\Travail\\ENSEA\\2A\\Projet\\SaintGraal\\RUBIKSCUBESOLVER_Final\\RubikSolver.jar", buffer, sizeof(buffer));
    separateur("010001010100011011010001", resultat);


    //Mon mémoire
    int fd;
    void *virtual_base;
    volatile uint32_t *reg_fpga;

    

    printf("\nOuverture de la mémoire\n");
    fflush(stdout);
    // On ouvre la Memory Map pour accéder à la mémoire physique. 
    if( (fd = open("/dev/mem", (O_RDWR | O_SYNC))) == -1 ) {
        perror("ERREUR: Impossible d'ouvrir /dev/mem");
        return 1;
    }

    printf("Mapping de la mémoire\n");
    fflush(stdout);
    // On mappe l'adresse physique du pont dans la mémoire virtuelle de notre processus.
    virtual_base = mmap(NULL, LWHPS2FPGA_SPAN, (PROT_READ | PROT_WRITE), MAP_SHARED, fd, LWHPS2FPGA_BASE);
    
    if(virtual_base == MAP_FAILED) {
        perror("ERREUR: mmap a échoué");
        close(fd);
        return 1;
    }


    reg_fpga = (uint32_t *)(virtual_base + IP_OFFSET);

    printf("Écriture\n");
    fflush(stdout);

    uint32_t valeur = *reg_fpga;
    printf("Valeur lue : 0x%08X\n", valeur);

    /*
    for (int i = 0; i < 32; i++) {
        *(reg_fpga + i) = resultat[i];
    }
    */

    // On libère la mémoire mappée et on ferme le descripteur de fichier
    if (munmap(virtual_base, LWHPS2FPGA_SPAN + IP_OFFSET) != 0) {
        perror("ERREUR: munmap a échoué");
    }
    close(fd);


    return 0;
}