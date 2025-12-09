#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>
#include "utils.h"


#define IP_OFFSET 0x00011000

// Fonction pour séparer une chaîne de caractères binaire en 20 mots de taille souhaitée (la chaîne de caractère doit avoir un multiple de six comme longueur)
void separateur(const char *str, uint8_t resultat[32]) {
    int len = strlen(str);
    int width = 6;
    int nb_mots = len/6;
    char listemots[nb_mots][7];

    for (int i = 0; i < nb_mots; i++) {
        for (int j = 0; j < width; j++) {

            listemots[i][j] = str[(i * width) + j];
        }
        listemots[i][width] = '\0';
        resultat[i] = convertisseur32bits(listemots[i]);
    }
    for (int i = nb_mots; i<32; i++){
        resultat[i]=0;
    }
}


int Recuperateur(const char *chemin, char *buffer, size_t bufferSize){
    FILE *fp;
    char commande[512];

    snprintf(commande, sizeof(commande), "java -jar \"%s\"", chemin);

    fp = _popen(commande, "r");

    //Gestion erreurs
    if (fp == NULL){                
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

uint8_t convertisseur32bits(const char *binaire){
    uint8_t motbits = 0;
    while (*binaire) {
        motbits <<= 1;
        if (*binaire == '1') motbits |= 1;
        binaire++;
    }
    return motbits;
}



int main() {
    char buffer[256];
    uint8_t resultat[32]={0x0};

    //int chaine = Recuperateur("C:\\Travail\\ENSEA\\2A\\Projet\\SaintGraal\\RUBIKSCUBESOLVER-Copie\\RubikSolver.jar", buffer, sizeof(buffer));
    separateur("10001111010010010001110011010010001110001001010010001101110010001101100011110001000110001111110001100", resultat);


    /*volatile uint32_t *reg_fpga = (uint32_t *)(IP_OFFSET);
    
    for (int i = 0; i < 32; i++) {
        *(reg_fpga + i) = resultat[i];
    }*/

    printf("%u", resultat[30]);



    /*uint32_t w1 = convertisseur32bits(mots.mot1);
    uint32_t w2 = convertisseur32bits(mots.mot2);
    uint32_t w3 = convertisseur32bits(mots.mot3);
    uint32_t w4 = convertisseur32bits(mots.mot4);
    uint32_t w5 = convertisseur32bits(mots.mot5);
    uint32_t w6 = convertisseur32bits(mots.mot6);

    volatile uint32_t *reg1 = (uint32_t *)(REG_1);
    volatile uint32_t *reg2 = (uint32_t *)(REG_2);
    volatile uint32_t *reg3 = (uint32_t *)(REG_3);
    volatile uint32_t *reg4 = (uint32_t *)(REG_4);
    volatile uint32_t *reg5 = (uint32_t *)(REG_5);
    volatile uint32_t *reg6 = (uint32_t *)(REG_6);

    *reg1 = w1;
    *reg2 = w2;
    *reg3 = w3;
    *reg4 = w4;
    *reg5 = w5;
    *reg6 = w6;

    printf("mot1 (hex) = 0x%08X\n", w1);*/
    return 0;
}

